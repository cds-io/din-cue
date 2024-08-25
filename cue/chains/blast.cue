package chains

import (
	"acme.io/contracts/schema"
	"acme.io/contracts/ethmethods"
	"list"
)

// Custom methods for Blast network
_customBlastMethods: (#ToMethods & {
	_names: _blastCustoms
	_ns:    "blast"
}).methods

_blastCustoms: [
	"eth_getBalanceValues",
]

// Combine custom methods with Ethereum methods
_allBlast: list.Concat([
	_customBlastMethods,
	ethmethods.ethMethods,
	ethmethods.filterMethods,
])

// Sort all Blast methods
#allBlastMethods: (schema.#SortAndAddBit & {
	input: _allBlast
}).sorted

// Define the Blast Mainnet network
_blastMainnet: schema.#Network & {
	name:        "blast"
	flavor:      "mainnet"
	description: "EVM-compatible Layer-2 on Ethereum"
	version:     "1.0.0"
	methods:     #allBlastMethods
}

// Define the Blast Testnet network
_blastTestnet: schema.#Network & {
	name:        "blast"
	flavor:      "testnet"
	description: "EVM-compatible Layer-2 on Ethereum"
	version:     "1.0.0"
	methods:     #allBlastMethods
}

result: result & {
	blast: mainnet: _blastMainnet
	blast: testnet: _blastTestnet
}
