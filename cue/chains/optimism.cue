package chains

import (
	"acme.io/contracts/schema"
	"acme.io/contracts/ethmethods"
	"list"
)

// Combine all methods for Optimism network
_allOptimism: list.Concat([
	ethmethods.ethMethods,
	ethmethods.filterMethods,
])

// Sort all Optimism methods
#allOptimismMethods: (schema.#SortAndAddBit & {
	input: _allOptimism
}).sorted

// Define the Optimism Mainnet network
_optimismMainnet: schema.#Network & {
	name:        "optimism"
	flavor:      "mainnet"
	description: "EVM-compatible Layer-2 on Ethereum (mainnet)"
	version:     "1.0.0"
	methods:     #allOptimismMethods
}

// Define the Optimism Sepolia test network
_optimismSepolia: schema.#Network & {
	name:        "optimism"
	flavor:      "sepolia"
	description: "EVM-compatible Layer-2 on Ethereum (sepolia)"
	version:     "1.0.0"
	methods:     #allOptimismMethods
}

result: result & {
	optimism: mainnet: _optimismMainnet
	optimism: sepolia: _optimismSepolia
}
