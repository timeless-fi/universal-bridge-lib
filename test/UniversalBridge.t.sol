// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.4;

import "forge-std/Test.sol";

import "./mocks/MockBridge.sol";

contract UniversalBridgeTest is Test {
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
}
