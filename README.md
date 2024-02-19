# [ENS ERC20](https://github.com/z0r0z/namebridge)  [![License: AGPL-3.0-only](https://img.shields.io/badge/License-AGPL-black.svg)](https://opensource.org/license/agpl-v3/) [![solidity](https://img.shields.io/badge/solidity-%5E0.8.24-black)](https://docs.soliditylang.org/en/v0.8.24/) [![Foundry](https://img.shields.io/badge/Built%20with-Foundry-000000.svg)](https://getfoundry.sh/) ![tests](https://github.com/z0r0z/ens-erc20/actions/workflows/ci.yml/badge.svg)

`ENS ERC20` token designed to enable simple token bridging of ENS name ownership artifacts to L2s.

Factory is deployed to [`0x000000008B009D81C933a72545Ed7500cbB5B9D1`](https://etherscan.io/address/0x000000008b009d81c933a72545ed7500cbb5b9d1#code) and the base implementation is deployed to [`0xEBb49317E567a40cF468c409409aD59a8f67ddE6`](https://etherscan.io/address/0xebb49317e567a40cf468c409409ad59a8f67dde6#code).

Each created ERC20 token is a minimal proxy clone with the immutable argument of an ENS `node` bytes32 that also serves as the salt of its create2 deterministic deployment. This is overall just very gas efficient. There will only ever be one ERC20 for each ENS `node`. Ultimate control of these ERC20 tokens are left to the then-current owner of the ENS name or `node` or accounts that receive an approval. This means that there is a revokable permission to send these tokens. The use case for this is to allow L2 bridges to pull and return tokens. This may or not work but let's try and see. For the avoidance of doubt, the L1 ENS ERC20 token will always ultimately be under the control of whoever owns the underlying ENS name and NFT. This ownership updates in real-time with changes in ENS ownership without the need for any intervention on behalf of the ERC20. Also to be clear: There is no need to move the ENS name or NFT to take advantage of this system. Users can deploy the ERC20 equivalent of their ENS name or a relayer can. The ENS owner can mint and burn at their pleasure and transfer the tokens from any address on L1 once deployed. On L2, they may consider giving less than the full amount on L2 to delegate permissions. An intuitive check of "who owns the L1 ENS" on L2 will just be checking who owns a majority of the ERC20 artifacts on the relevant L2.

## Getting Started

Run: `curl -L https://foundry.paradigm.xyz | bash && source ~/.bashrc && foundryup`

Build the foundry project with `forge build`. Run contract tests with `forge test`. Measure gas fees with `forge snapshot`. Format code with `forge fmt`.

## Blueprint

```txt
lib
├─ forge-std — https://github.com/foundry-rs/forge-std
├─ solady — https://github.com/vectorized/solady
src
├─ ENS_ERC20 — ENS_ERC20 Contract
test
└─ ENS_ERC20.t - Test ENS_ERC20 Contract
```

## Disclaimer

*These smart contracts and testing suite are being provided as is. No guarantee, representation or warranty is being made, express or implied, as to the safety or correctness of anything provided herein or through related user interfaces. This repository and related code have not been audited and as such there can be no assurance anything will work as intended, and users may experience delays, failures, errors, omissions, loss of transmitted information or loss of funds. The creators are not liable for any of the foregoing. Users should proceed with caution and use at their own risk.*

## License

See [LICENSE](./LICENSE) for more details.
