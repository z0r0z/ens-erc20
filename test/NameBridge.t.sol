// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.19;

import {IArbInbox, NameBridge} from "../src/NameBridge.sol";
import {Test} from "../lib/forge-std/src/Test.sol";

contract NameBridgeTest is Test {
    NameBridge bridge;

    string constant name = "z0r0z";

    address constant Z0R0Z_DOT_ETH = 0x1C0Aa8cCD568d90d61659F060D1bFb1e6f855A20;

    IArbInbox constant ARB_INBOX = IArbInbox(0x4Dbd4fc535Ac27206064B68FfCf827b0A60BAB3f);

    function setUp() public payable {
        vm.createSelectFork(vm.rpcUrl("main"));
        bridge = new NameBridge();
    }

    function testBridgeName() public payable {
        uint256 value = uint32(bytes4(keccak256(abi.encodePacked(Z0R0Z_DOT_ETH, name))));
        vm.prank(Z0R0Z_DOT_ETH);
        bridge.bridgeName{value: value}(name);
    }
}
