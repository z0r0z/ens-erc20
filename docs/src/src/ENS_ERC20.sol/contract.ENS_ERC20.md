# ENS_ERC20
[Git Source](https://github.com/z0r0z/bridge-ens/blob/972fbda0a2afa1ffe9b68ddc93ba2a6e0f5fd425/src/ENS_ERC20.sol)

Simple ERC20 token for representing ENS ownership.


## State Variables
### ENS_REGISTRY

```solidity
IENSHelper constant ENS_REGISTRY = IENSHelper(0x00000000000C2E074eC69A0dFb2997BA6C7d2e1e);
```


### ENS_WRAPPER

```solidity
IENSHelper constant ENS_WRAPPER = IENSHelper(0xD4416b13d2b3a9aBae7AcD5D6C2BbDBE25686401);
```


### allowance

```solidity
mapping(address => mapping(address => uint256)) public allowance;
```


### balanceOf

```solidity
mapping(address => uint256) public balanceOf;
```


### name

```solidity
string public constant name = "ENS ERC20";
```


### symbol

```solidity
string public constant symbol = "ENS20";
```


### decimals

```solidity
uint256 public constant decimals = 18;
```


### totalSupply

```solidity
uint256 public totalSupply;
```


## Functions
### approve


```solidity
function approve(address to, uint256 amount) public payable returns (bool);
```

### transfer


```solidity
function transfer(address to, uint256 amount) public payable returns (bool);
```

### transferFrom


```solidity
function transferFrom(address from, address to, uint256 amount) public payable returns (bool);
```

### mint


```solidity
function mint(address to, uint256 amount) public payable;
```

### burn


```solidity
function burn(address from, uint256 amount) public payable;
```

### owner


```solidity
function owner() public view returns (address _owner);
```

### node


```solidity
function node() public pure returns (bytes32 _node);
```

## Events
### Transfer

```solidity
event Transfer(address indexed from, address indexed to, uint256 amount);
```

### Approval

```solidity
event Approval(address indexed from, address indexed to, uint256 amount);
```

## Errors
### Unauthorized

```solidity
error Unauthorized();
```

