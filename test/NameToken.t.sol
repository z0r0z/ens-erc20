// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.19;

import {Test} from "../lib/forge-std/src/Test.sol";

import {NameToken, NameTokenFactory} from "../src/NameToken.sol";

contract NameTokenTest is Test {
    NameTokenFactory factory;

    string constant name = "z0r0z";
    address constant Z0R0Z_DOT_ETH = 0x1C0Aa8cCD568d90d61659F060D1bFb1e6f855A20;
    bytes32 constant znode = 0xa5b4d411903b3ea236b2defe1f96e5a68505e58362e3d8d323fde0b6f8be8ad5;

    function setUp() public payable {
        vm.createSelectFork(vm.rpcUrl("main"));
        factory = new NameTokenFactory();
    }

    function testCreateToken() public payable {
        factory.createToken(znode);
    }

    function testTokenNode() public payable {
        NameToken token = NameToken(factory.createToken(znode));
        assertEq(token.node(), znode);
    }
}

interface IERC20 {
    function approve(address, uint256) external returns (bool);
}
