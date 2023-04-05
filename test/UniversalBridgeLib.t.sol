// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.4;

import "forge-std/Test.sol";

import "./mocks/MockBridge.sol";

contract UniversalBridgeLibTest is Test {
    MockBridge bridge;

    uint256 internal constant CHAINID_ARBITRUM = 42161;
    uint256 internal constant CHAINID_OPTIMISM = 10;
    uint256 internal constant CHAINID_POLYGON = 137;
    uint256 internal constant CHAINID_BSC = 56;
    uint256 internal constant CHAINID_GNOSIS = 100;

    function setUp() public {
        bridge = new MockBridge();
    }

    function test_sendMessageArbitrum(address recipient, bytes calldata data) external {
        uint256 requiredValue = bridge.getRequiredMessageValue(CHAINID_ARBITRUM, data.length, 1e6);
        bridge.sendMessage{value: requiredValue}(CHAINID_ARBITRUM, recipient, data, 1e6);
    }

    function test_sendMessageOptimism(address recipient, bytes calldata data) external {
        bridge.sendMessage(CHAINID_OPTIMISM, recipient, data, 1e6);
    }

    function test_sendMessagePolygon(address recipient, bytes calldata data) external {
        bridge.sendMessage(CHAINID_POLYGON, recipient, data, 1e6);
    }

    function test_sendMessageBSC(address recipient, bytes calldata data) external {
        bridge.sendMessage(CHAINID_BSC, recipient, data, 1e6);
    }

    function test_sendMessageGnosis(address recipient, bytes calldata data) external {
        bridge.sendMessage(CHAINID_GNOSIS, recipient, data, 1e6);
    }

    /// -----------------------------------------------------------------------
    /// Failure tests
    /// -----------------------------------------------------------------------

    function test_fail_gasLimitTooLarge_optimism(address recipient, bytes calldata data) external {
        uint256 gasLimit = uint256(type(uint32).max) + 1;

        vm.expectRevert(UniversalBridgeLib.UniversalBridgeLib__GasLimitTooLarge.selector);
        bridge.sendMessage(CHAINID_OPTIMISM, recipient, data, gasLimit);
    }

    function test_fail_gasLimitTooLarge_bsc(address recipient, bytes calldata data) external {
        uint256 gasLimit = 1e6 + 1;

        vm.expectRevert(UniversalBridgeLib.UniversalBridgeLib__GasLimitTooLarge.selector);
        bridge.sendMessage(CHAINID_BSC, recipient, data, gasLimit);
    }

    function test_fail_gasLimitTooLarge_gnosis(address recipient, bytes calldata data) external {
        uint256 gasLimit = 4e6 + 1;

        vm.expectRevert(UniversalBridgeLib.UniversalBridgeLib__GasLimitTooLarge.selector);
        bridge.sendMessage(CHAINID_GNOSIS, recipient, data, gasLimit);
    }

    function test_fail_noMsgValue_optimism(address recipient, bytes calldata data) external {
        vm.expectRevert(UniversalBridgeLib.UniversalBridgeLib__MsgValueNotSupported.selector);
        bridge.sendMessage{value: 1 ether}(CHAINID_OPTIMISM, recipient, data, 1e6);
    }

    function test_fail_noMsgValue_polygon(address recipient, bytes calldata data) external {
        vm.expectRevert(UniversalBridgeLib.UniversalBridgeLib__MsgValueNotSupported.selector);
        bridge.sendMessage{value: 1 ether}(CHAINID_POLYGON, recipient, data, 1e6);
    }

    function test_fail_noMsgValue_bsc(address recipient, bytes calldata data) external {
        vm.expectRevert(UniversalBridgeLib.UniversalBridgeLib__MsgValueNotSupported.selector);
        bridge.sendMessage{value: 1 ether}(CHAINID_BSC, recipient, data, 1e6);
    }

    function test_fail_noMsgValue_gnosis(address recipient, bytes calldata data) external {
        vm.expectRevert(UniversalBridgeLib.UniversalBridgeLib__MsgValueNotSupported.selector);
        bridge.sendMessage{value: 1 ether}(CHAINID_GNOSIS, recipient, data, 1e6);
    }

    function test_fail_invalidChainId(address recipient, bytes calldata data) external {
        vm.expectRevert(UniversalBridgeLib.UniversalBridgeLib__ChainIdNotSupported.selector);
        bridge.sendMessage(696969, recipient, data, 1e6);
    }
}
