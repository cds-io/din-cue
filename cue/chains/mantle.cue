package chains

import (
	"acme.io/contracts/schema"
	"acme.io/contracts/ethmethods"
	"list"
)

// The list of methods to exclude from the eth namespace
_ethMethodsToExcludeForMantle: ethmethods.#EthMethodNames & [
	"eth_accounts",
	"eth_getBlockReceipts",
	"eth_getUncleByBlockNumberAndIndex",
	"eth_getWork",
	"eth_hashrate",
	"eth_mining",
	"eth_sendTransaction",
	"eth_sign",
	"eth_submitWork",
]

// Mantle has all the eth namespace methods except for the excluded ones above
_filteredMantleEth: [
	for m in ethmethods.ethMethods
	if !list.Contains(_ethMethodsToExcludeForMantle, m.name) {m},
]

// Combine all methods for Mantle network
_allMantle: list.Concat([
	_filteredMantleEth,
])

// Sort all Mantle methods
#allMantleMethods: (schema.#SortAndAddBit & {
	input: _allMantle
}).sorted

// Define the Mantle Mainnet network
_mantleMainnet: schema.#Network & {
	name:        "mantle"
	flavor:      "mainnet"
	description: "Mantle mainnet network"
	version:     "1.0.0"
	methods:     #allMantleMethods
}

// Define the Mantle Sepolia test network
_mantleSepolia: schema.#Network & {
	name:        "mantle"
	flavor:      "sepolia"
	description: "Mantle Sepolia test network"
	version:     "1.0.0"
	methods:     #allMantleMethods
}

result: result & {
	mantle: mainnet: _mantleMainnet
	mantle: sepolia: _mantleSepolia
}
