// ⌘ ⌘ ⌘ ⌘ ⌘ ⌘ ⌘ ⌘ ⌘ ⌘ ⌘ ⌘ ⌘ ⌘ ⌘ ⌘ ⌘ ⌘ ⌘
// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.24;

/// @notice Simple ERC20 token for representing ENS ownership.
contract ENS_ERC20 {
    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approval(address indexed from, address indexed to, uint256 amount);

    IENSHelper constant ENS_REGISTRY = 
        IENSHelper(0x00000000000C2E074eC69A0dFb2997BA6C7d2e1e);
    IENSHelper constant ENS_WRAPPER = 
        IENSHelper(0xD4416b13d2b3a9aBae7AcD5D6C2BbDBE25686401);
    
    mapping(address => mapping(address => uint256)) 
        public allowance;
    mapping(address => uint256) 
        public balanceOf;

    string public constant name = "ENS ERC20";
    string public constant symbol = "ENS20";
    uint256 public constant decimals = 18;

    uint256 public totalSupply;

    error Unauthorized();

    function approve(address to, uint256 amount) public payable returns (bool) {
        allowance[msg.sender][to] = amount;
        emit Approval(msg.sender, to, amount);
        return true;
    }

    function transfer(address to, uint256 amount) public payable returns (bool) {
        return transferFrom(msg.sender, to, amount);
    }

    function transferFrom(address from, address to, uint256 amount)
        public
        payable
        returns (bool)
    {
        address _owner = owner();
        if (msg.sender != _owner)
            if (allowance[_owner][msg.sender] != type(uint256).max) 
                allowance[_owner][msg.sender] -= amount;
        balanceOf[from] -= amount;
        unchecked { balanceOf[to] += amount; }
        emit Transfer(from, to, amount);
        return true;
    }

    function mint(address to, uint256 amount) public payable {
        if (msg.sender != owner()) revert Unauthorized();
        totalSupply += amount;
        unchecked { balanceOf[to] += amount; }
        emit Transfer(address(0), to, amount);
    }

    function burn(address from, uint256 amount) public payable {
        if (msg.sender != owner()) revert Unauthorized();
        balanceOf[from] -= amount;
        unchecked { totalSupply -= amount; }
        emit Transfer(from, address(0), amount);
    }

    function owner() public view returns (address _owner) {
        bytes32 _node = node();
        _owner = ENS_REGISTRY.owner(_node);
        if (IENSHelper(_owner) == ENS_WRAPPER) _owner = ENS_WRAPPER.ownerOf(uint256(_node));
    }

    function node() public pure returns (bytes32 _node) {
        assembly ("memory-safe") {
            _node :=
                calldataload(sub(calldatasize(), shr(240, calldataload(sub(calldatasize(), 2)))))
        }
    }
}

interface IENSHelper {
    function owner(bytes32) external view returns (address);
    function ownerOf(uint256) external view returns (address);
}

/// @notice Simple ERC20 token factory for representing ENS ownership.
contract ENS_ERC20_FACTORY {
    ENS_ERC20 immutable implementation;

    constructor() payable { implementation = new ENS_ERC20(); }

    function createToken(bytes32 node) public payable returns (address instance) {
        bytes memory data = bytes.concat(node);
        ENS_ERC20 _implementation = implementation;
        assembly {
            let mBefore3 := mload(sub(data, 0x60))
            let mBefore2 := mload(sub(data, 0x40))
            let mBefore1 := mload(sub(data, 0x20))
            let dataLength := mload(data)
            let dataEnd := add(add(data, 0x20), dataLength)
            let mAfter1 := mload(dataEnd)
            let extraLength := add(dataLength, 2)
            mstore(data, 0x5af43d3d93803e606057fd5bf3)
            mstore(sub(data, 0x0d), _implementation)
            mstore(
                sub(data, 0x21),
                or(shl(0x48, extraLength), 0x593da1005b363d3d373d3d3d3d610000806062363936013d73)
            )
            mstore(
                sub(data, 0x3a), 0x9e4ac34f21c619cefc926c8bd93b54bf5a39c7ab2127a895af1cc0691d7e3dff
            )
            mstore(
                sub(data, add(0x59, lt(extraLength, 0xff9e))),
                or(shl(0x78, add(extraLength, 0x62)), 0xfd6100003d81600a3d39f336602c57343d527f)
            )
            mstore(dataEnd, shl(0xf0, extraLength))
            instance := create2(0, sub(data, 0x4c), add(extraLength, 0x6c), node)
            if iszero(instance) {
                mstore(0x00, 0x30116425) // `DeploymentFailed()`.
                revert(0x1c, 0x04)
            }
            mstore(dataEnd, mAfter1)
            mstore(data, dataLength)
            mstore(sub(data, 0x20), mBefore1)
            mstore(sub(data, 0x40), mBefore2)
            mstore(sub(data, 0x60), mBefore3)
        }
    }
}
