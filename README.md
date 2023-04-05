# UniversalBridgeLib

Unified library for sending messages from Ethereum to other chains and rollups.

It is essentially a quality-of-life wrapper around official bridges to make the developer experience simpler while maintaining the same security assumptions as the official bridges. This makes it much more secure than "omnichain" solutions like LayerZero, at least for rollups like Arbitrum and Optimism where the official bridge has the same security assumptions as the network itself. Of course, UniversalBridgeLib only supports one-way messaging from Ethereum to other networks, so it is less capable than "omnichain" solutions, but it is still useful for use cases like cross-chain governance.

## Supported chains

- Arbitrum
- Optimism
- Polygon
- Binance Smart Chain
- Gnosis Chain

## Usage

Sending a message is as easy as:

```solidity
address recipient = address(0x69);
bytes memory data = "Hello world";
uint256 gasLimit = 1e6;

uint256 requiredValue = UniversalBridgeLib.getRequiredMessageValue(UniversalBridgeLib.CHAINID_ARBITRUM, data.length, gasLimit);
UniversalBridgeLib.sendMessage{value: requiredValue}(UniversalBridgeLib.CHAINID_ARBITRUM, recipient, data, gasLimit);
```

Contracts on the receiving end of the message should have cross-chain support, which can be done by inheriting from the corresponding [OpenZeppelin Cross Chain Awareness](https://docs.openzeppelin.com/contracts/4.x/api/crosschain) specialization contract.

## Installation

To install with [Foundry](https://github.com/foundry-rs/foundry):

```bash
forge install timeless-fi/universal-bridge-lib
```

## Local development

This project uses [Foundry](https://github.com/foundry-rs/foundry) as the development framework.

Please create a `.env` file before testing. An example can be found in `.env.example`.

### Dependencies

```bash
forge install
```

### Compilation

```bash
forge build
```

### Testing

```bash
forge test -f mainnet
```