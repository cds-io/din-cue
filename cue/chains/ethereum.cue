package chains

import (
	"acme.io/contracts/schema"
	"acme.io/contracts/ethmethods"
	"list"
)

// Combine all methods for Ethereum network
_allEthereum: list.Concat([
	ethmethods.ethMethods,
	ethmethods.debugMethods,
	ethmethods.filterMethods,
	ethmethods.traceMethods,
	ethmethods.subscribeMethods,
])

// Sort all Ethereum methods
_meta: schema.#SortAndAddBit & {
	input: _allEthereum
}

#allEthereumMethods: _meta.sorted
#ethereumDict:       _meta.dict

// Define the Ethereum Mainnet network
_ethereumMainnet: schema.#Network & {
	name:        "ethereum"
	flavor:      "mainnet"
	description: "The main Ethereum network"
	version:     "1.0.0"
	methods:     #allEthereumMethods
}

// Define the Ethereum Sepolia test network
_ethereumSepolia: schema.#Network & {
	name:        "ethereum"
	flavor:      "sepolia"
	description: "Ethereum Sepolia test network"
	version:     "1.0.0"
	methods:     #allEthereumMethods
}

// Define the Ethereum Goerli test network
_ethereumGoerli: schema.#Network & {
	name:        "ethereum"
	flavor:      "goerli"
	description: "Ethereum Goerli test network"
	version:     "1.0.0"
	methods:     #allEthereumMethods
}

result: result & {
	ethereum: mainnet: _ethereumMainnet
	ethereum: sepolia: _ethereumSepolia
	ethereum: goerli:  _ethereumGoerli
}
