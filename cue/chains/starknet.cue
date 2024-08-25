package chains

import (
	"acme.io/contracts/schema"
	"list"
)

// Metadata for Starknet
_Meta: {
	// Methods sourced from ...
	reference: "https://github.com/starkware-libs/starknet-specs.git"
}

_nodeMethodsStarkNet: list.UniqueItems
_nodeMethodsStarkNet: [
	"starknet_specVersion",
	"starknet_getBlockWithTxHashes",
	"starknet_getBlockWithTxs",
	"starknet_getBlockWithReceipts",
	"starknet_getStateUpdate",
	"starknet_getStorageAt",
	"starknet_getTransactionStatus",
	"starknet_getTransactionByHash",
	"starknet_getTransactionByBlockIdAndIndex",
	"starknet_getTransactionReceipt",
	"starknet_getClass",
	"starknet_getClassHashAt",
	"starknet_getClassAt",
	"starknet_getBlockTransactionCount",
	"starknet_call",
	"starknet_estimateFee",
	"starknet_estimateMessageFee",
	"starknet_blockNumber",
	"starknet_blockHashAndNumber",
	"starknet_chainId",
	"starknet_syncing",
	"starknet_getEvents",
	"starknet_getNonce",
]

// Starknet node methods
_starknetNodeMethods: (#ToMethods & {
	_names: _nodeMethodsStarkNet
	_ns:    "node"
}).methods

// Starknet trace methods
_starknetTraceMethods: (#ToMethods & {
	_names: [
		"starknet_traceTransaction",
		"starknet_simulateTransactions",
		"starknet_traceBlockTransactions",
	] & list.UniqueItems
	_ns: "trace"
}).methods

// List of Starknet write methods
_starknetWriteMethods: (#ToMethods & {
	_names: [
		"starknet_addInvokeTransaction",
		"starknet_addDeclareTransaction",
		"starknet_addDeployAccountTransaction",
	] & list.UniqueItems
	_ns: "write"
}).methods

// Combine all methods for Starknet network
_allStarknet: list.Concat([
	_starknetNodeMethods,
	_starknetTraceMethods,
	_starknetWriteMethods,
])

// Sort all Starknet methods
#allStarknetMethods: (schema.#SortAndAddBit & {
	input: _allStarknet
}).sorted

// Define the Starknet Mainnet network
_starknetMainnet: schema.#Network & {
	name:        "starknet"
	flavor:      "mainnet"
	description: "Decentralized, permissionless and scalable Layer-2 network protocol developed by StarkWare for the Ethereum network."
	version:     "1.0.0"
	methods:     #allStarknetMethods
}

// Define the Starknet Sepolia test network
_starknetSepolia: schema.#Network & {
	name:        "starknet"
	flavor:      "sepolia"
	description: "Decentralized, permissionless and scalable Layer-2 network protocol developed by StarkWare for the Ethereum network."
	version:     "1.0.0"
	methods:     #allStarknetMethods
}

result: result & {
	starknet: mainnet: _starknetMainnet
	starknet: sepolia: _starknetSepolia
}
