# NameBridge
[Git Source](https://github.com/z0r0z/bridge-ens/blob/fa4cb021d70ae8425fb4517fbc4189aee20b9727/src/NameBridge.sol)

ENS Name Bridge for Arbitrum Layer 2.

*This contract is deployed on L1 and L2.
Bridging is done L1-side and registry, L2.
This is done to conjoin these addresses.*


## State Variables
### ENS_REGISTRY

```solidity
IENSHelper constant ENS_REGISTRY = IENSHelper(0x00000000000C2E074eC69A0dFb2997BA6C7d2e1e);
```


### ENS_WRAPPER

```solidity
IENSHelper constant ENS_WRAPPER = IENSHelper(0xD4416b13d2b3a9aBae7AcD5D6C2BbDBE25686401);
```


### ARB_INBOX

```solidity
IArbInbox constant ARB_INBOX = IArbInbox(0x4Dbd4fc535Ac27206064B68FfCf827b0A60BAB3f);
```


### owners

```solidity
mapping(string => address) public owners;
```


### _idnamap

```solidity
bytes1[] _idnamap;
```


## Functions
### constructor


```solidity
constructor() payable;
```

### bridgeName

===================== BRIDGE OPERATIONS ===================== ///


```solidity
function bridgeName(string calldata name) public payable;
```

### registerName


```solidity
function registerName(string calldata name, uint32 msgVal) public;
```

### _getENSOwnership

====================== ENS VERIFICATION ====================== ///


```solidity
function _getENSOwnership(string calldata name)
    internal
    view
    returns (address owner, address receiver);
```

### _namehash


```solidity
function _namehash(string memory domain) internal view returns (bytes32 node);
```

### _labelhash


```solidity
function _labelhash(string memory domain, uint256 start, uint256 end)
    internal
    pure
    returns (bytes32 hash);
```

## Errors
### Reserved

```solidity
error Reserved();
```

### Unauthorized

```solidity
error Unauthorized();
```

### InvalidMsgVal

```solidity
error InvalidMsgVal();
```

## Enums
### Rule

```solidity
enum Rule {
    DISALLOWED,
    VALID
}
```

