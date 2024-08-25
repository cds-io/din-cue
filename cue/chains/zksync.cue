package chains

import (
	"acme.io/contracts/schema"
	"acme.io/contracts/ethmethods"
	"list"
)

// The list of methods to exclude from the eth namespace
_ethMethodsExcludedFromZKSync: ethmethods.#EthMethodNames & [
	"eth_accounts",
	"eth_coinbase",
	"eth_getBlockReceipts",
	"eth_getUncleByBlockNumberAndIndex",
	"eth_getWork",
	"eth_hashrate",
	"eth_mining",
	"eth_sendTransaction",
	"eth_sign",
	"eth_submitWork",
]

// zkSync has all the eth namespace methods except for the excluded ones above
_zkyncEthMethods: [
	for m in ethmethods.ethMethods
	if !list.Contains(_ethMethodsExcludedFromZKSync, m.name) {m},
]

// Combine all methods for zkSync network
_allZKSync: list.Concat([
	_zkyncEthMethods,
	ethmethods.filterMethods,
])

// Sort all zkSync methods
#allZKSyncMethods: (schema.#SortAndAddBit & {
	input: _allZKSync
}).sorted

// Define the zkSync Mainnet network
_zksyncMainnet: schema.#Network & {
	name:        "zksync"
	flavor:      "mainnet"
	description: "zkSync mainnet network"
	version:     "1.0.0"
	methods:     #allZKSyncMethods
}

// Define the zkSync Sepolia test network
_zksyncSepolia: schema.#Network & {
	name:        "zksync"
	flavor:      "sepolia"
	description: "zkSync Sepolia test network"
	version:     "1.0.0"
	methods:     #allZKSyncMethods
}

result: result & {
	zksync: mainnet: _zksyncMainnet
	zksync: sepolia: _zksyncSepolia
}
