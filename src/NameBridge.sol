// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.19;

/// @notice ENS Name Bridge for Arbitrum Layer 2.
/// @dev This contract is deployed on L1 and L2.
/// Bridging is done L1-side and registry, L2.
/// This is done to conjoin these addresses.
contract NameBridge {
    error Reserved();
    error Unauthorized();
    error InvalidMsgVal();

    IENSHelper constant ENS_REGISTRY = IENSHelper(0x00000000000C2E074eC69A0dFb2997BA6C7d2e1e);
    IENSHelper constant ENS_WRAPPER = IENSHelper(0xD4416b13d2b3a9aBae7AcD5D6C2BbDBE25686401);
    IArbInbox constant ARB_INBOX = IArbInbox(0x4Dbd4fc535Ac27206064B68FfCf827b0A60BAB3f);

    mapping(string => address) public owners;

    bytes1[] _idnamap;

    enum Rule {
        DISALLOWED,
        VALID
    }

    constructor() payable {
        unchecked {
            for (uint256 i; i != ASCII_MAP.length; i += 2) {
                bytes1 r = ASCII_MAP[i + 1];
                for (uint8 j; j != uint8(ASCII_MAP[i]); ++j) {
                    _idnamap.push(r);
                }
            }
        }
    }

    /// ===================== BRIDGE OPERATIONS ===================== ///

    function bridgeName(string calldata name) public payable {
        (address owner, address receiver) = _getENSOwnership(name);
        if (msg.sender != owner) if (msg.sender != receiver) revert Unauthorized();
        if (msg.value != uint32(bytes4(keccak256(abi.encodePacked(msg.sender, name))))) {
            revert InvalidMsgVal();
        }
        ARB_INBOX.depositEth{value: msg.value}();
    }

    function registerName(string calldata name, uint32 msgVal) public {
        if (address(this).balance < msgVal) revert InvalidMsgVal();
        if (uint32(bytes4(keccak256(abi.encodePacked(msg.sender, name)))) != msgVal) {
            revert Unauthorized();
        }
        if (owners[name] == address(0)) owners[name] = msg.sender;
        else revert Reserved();
        payable(msg.sender).transfer(msgVal);
    }

    /// ====================== ENS VERIFICATION ====================== ///

    function _getENSOwnership(string calldata name)
        internal
        view
        returns (address owner, address receiver)
    {
        bytes32 node = _namehash(string(abi.encodePacked(name, ".eth")));
        owner = ENS_REGISTRY.owner(node);
        if (IENSHelper(owner) == ENS_WRAPPER) owner = ENS_WRAPPER.ownerOf(uint256(node));
        receiver = IENSHelper(ENS_REGISTRY.resolver(node)).addr(node);
    }

    function _namehash(string memory domain) internal view returns (bytes32 node) {
        uint256 i = bytes(domain).length;
        uint256 lastDot = i;
        unchecked {
            for (; i != 0; --i) {
                bytes1 c = bytes(domain)[i - 1];
                if (c == ".") {
                    node = keccak256(abi.encodePacked(node, _labelhash(domain, i, lastDot)));
                    lastDot = i - 1;
                    continue;
                }
                require(c < 0x80);
                bytes1 r = _idnamap[uint8(c)];
                require(uint8(r) != uint8(Rule.DISALLOWED));
                if (uint8(r) > 1) {
                    bytes(domain)[i - 1] = r;
                }
            }
        }
        return keccak256(abi.encodePacked(node, _labelhash(domain, i, lastDot)));
    }

    function _labelhash(string memory domain, uint256 start, uint256 end)
        internal
        pure
        returns (bytes32 hash)
    {
        assembly ("memory-safe") {
            hash := keccak256(add(add(domain, 0x20), start), sub(end, start))
        }
    }
}

interface IArbInbox {
    function depositEth() external payable returns (uint256);
}

interface IENSHelper {
    function addr(bytes32) external view returns (address);
    function owner(bytes32) external view returns (address);
    function ownerOf(uint256) external view returns (address);
    function resolver(bytes32) external view returns (address);
}

bytes constant ASCII_MAP =
    hex"2d00020101000a010700016101620163016401650166016701680169016a016b016c016d016e016f0170017101720173017401750176017701780179017a06001a010500";
