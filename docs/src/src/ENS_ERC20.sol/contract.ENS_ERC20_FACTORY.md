# ENS_ERC20_FACTORY
[Git Source](https://github.com/z0r0z/bridge-ens/blob/972fbda0a2afa1ffe9b68ddc93ba2a6e0f5fd425/src/ENS_ERC20.sol)

Simple ERC20 token factory for representing ENS ownership.


## State Variables
### implementation

```solidity
ENS_ERC20 immutable implementation;
```


## Functions
### constructor


```solidity
constructor() payable;
```

### createToken


```solidity
function createToken(bytes32 node) public payable returns (address instance);
```

