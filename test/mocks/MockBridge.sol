// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.4;

import "../../src/UniversalBridgeLib.sol";

contract MockBridge {
    function sendMessage(uint256 chainId, address recipient, bytes calldata data, uint256 gasLimit) external payable {
        UniversalBridgeLib.sendMessage(chainId, recipient, data, gasLimit);
    }

    function sendMessage(
        uint256 chainId,
        address recipient,
        bytes calldata data,
        uint256 gasLimit,
        uint256 maxFeePerGas
    ) external payable {
        UniversalBridgeLib.sendMessage(chainId, recipient, data, gasLimit, maxFeePerGas);
    }

    function getRequiredMessageValue(uint256 chainId, uint256 dataLength, uint256 gasLimit)
        external
        view
        returns (uint256)
    {
        return UniversalBridgeLib.getRequiredMessageValue(chainId, dataLength, gasLimit);
    }

    function getRequiredMessageValue(uint256 chainId, uint256 dataLength, uint256 gasLimit, uint256 maxFeePerGas)
        external
        view
        returns (uint256)
    {
        return UniversalBridgeLib.getRequiredMessageValue(chainId, dataLength, gasLimit, maxFeePerGas);
    }
}
