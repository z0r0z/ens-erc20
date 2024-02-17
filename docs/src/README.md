# [Name Bridge](https://github.com/z0r0z/namebridge)  [![License: AGPL-3.0-only](https://img.shields.io/badge/License-AGPL-black.svg)](https://opensource.org/license/agpl-v3/) [![solidity](https://img.shields.io/badge/solidity-%5E0.8.24-black)](https://docs.soliditylang.org/en/v0.8.24/) [![Foundry](https://img.shields.io/badge/Built%20with-Foundry-000000.svg)](https://getfoundry.sh/) ![tests](https://github.com/z0r0z/zenplate/actions/workflows/ci.yml/badge.svg)

ENS Name Bridge for Arbitrum Layer 2. OP soon too.

Allows users to send a message to claim their ENS on L2. Uses msg.value for claim encoding and perceived simplicity.

## Getting Started

Run: `curl -L https://foundry.paradigm.xyz | bash && source ~/.bashrc && foundryup`

Build the foundry project with `forge build`. Run contract tests with `forge test`. Measure gas fees with `forge snapshot`. Format code with `forge fmt`.

## Blueprint

```txt
lib
├─ forge-std — https://github.com/foundry-rs/forge-std
├─ solady — https://github.com/vectorized/solady
src
├─ NameBridge — Name Bridge Contract
test
└─ NameBridge.t - Test Name Bridge Contract
```

## Disclaimer

*These smart contracts and testing suite are being provided as is. No guarantee, representation or warranty is being made, express or implied, as to the safety or correctness of anything provided herein or through related user interfaces. This repository and related code have not been audited and as such there can be no assurance anything will work as intended, and users may experience delays, failures, errors, omissions, loss of transmitted information or loss of funds. The creators are not liable for any of the foregoing. Users should proceed with caution and use at their own risk.*

## License

See [LICENSE](./LICENSE) for more details.
