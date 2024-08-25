package chains

import (
	"acme.io/contracts/schema"
	"acme.io/contracts/ethmethods"
	"list"
)

// These methods are not in our reference `ethmethods`, so we define them with
// their own namespace

// Custom methods for Arbitrum network
_arbMethods: (#ToMethods & {
	_names: _arbCustoms
	_ns:    "arbtrace"
}).methods

_arbCustoms: list.UniqueItems
_arbCustoms: [
	"arbtrace_block",
	"arbtrace_call",
	"arbtrace_callMany",
	"arbtrace_filter",
	"arbtrace_get",
	"arbtrace_replayBlockTransactions",
	"arbtrace_replayTransaction",
	"arbtrace_transaction",
]

// Combine custom methods with Ethereum methods
_allArbitrum: list.Concat([_arbMethods, ethmethods.ethMethods, ethmethods.filterMethods])

// Sort all Arbitrum methods
#allArbitrumMethods: (schema.#SortAndAddBit & {
	input: _allArbitrum
}).sorted

// Define the Arbitrum Mainnet network
_arbitrumMainnet: schema.#Network & {
	name:        "arbitrum"
	flavor:      "mainnet"
	description: "EVM-compatible Layer-2 on Ethereum"
	version:     "1.0.0"
	methods:     #allArbitrumMethods
}

// Add the `arbitrum/mainnet` path to the result object
result: schema.#NetworksConfig
result: result & {
	arbitrum: mainnet: _arbitrumMainnet
}
