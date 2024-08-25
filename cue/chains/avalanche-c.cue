package chains

import (
	"acme.io/contracts/schema"
	"acme.io/contracts/ethmethods"
	"list"
)

// Avalanche has a subset of our reference methods

_allAvalanchec: list.Concat([
	ethmethods.ethMethods,
	ethmethods.debugMethods,
	ethmethods.filterMethods,
])

#allAvalanchecMethods: (schema.#SortAndAddBit & {
	input: _allAvalanchec
}).sorted

_avalanchecMainnet: schema.#Network & {
	name:        "avalanchec"
	flavor:      "mainnet"
	description: "The C-Chain is the default smart contract blockchain on Avalanche and enables the creation of any EVM-compatible applications"
	version:     "1.0.0"
	methods:     #allAvalanchecMethods
}

result: result & {
	avalanchec: mainnet: _avalanchecMainnet
}
