package chains

import (
	"acme.io/contracts/schema"
	"acme.io/contracts/ethmethods"
	"list"
)

// The list of methods to exclude from the eth namespace
_ethMethodsToExcludeForBsc: list.UniqueItems
_ethMethodsToExcludeForBsc: ethmethods.#EthMethodNames & [
	"eth_coinbase",
	"eth_createAccessList",
	"eth_feeHistory",
	"eth_getUncleCountByBlockHash",
	"eth_getUncleCountByBlockNumber",
	"eth_getWork",
	"eth_hashrate",
	"eth_mining",
	"eth_protocolVersion",
	"eth_sign",
	"eth_submitWork",
	"web3_clientVersion",

	//  validation error
	//    conflicting values "web3_sha3" and "vveb3_clientVersion"
	//	"vveb3_clientVersion", 
]

// BSC has all the eth namespace methods except for the excluded ones above
_filteredEthMethods: [
	for m in ethmethods.ethMethods
	if !list.Contains(_ethMethodsToExcludeForBsc, m.name) {m},
]

// Additional BSC-specific methods
_bscTraceMethods: [
	{ns: "trace", name: "trace_call"},
	{ns: "trace", name: "trace_callMany"},
	{ns: "trace", name: "trace_get"},
	{ns: "trace", name: "trace_replayBlockTransactions"},
	{ns: "trace", name: "trace_replayTransaction"},
]

_bscWeb3Methods: [
	{ns: "web3", name: "web3_clientversion"},
]

// Combine all methods for BSC network
_allBsc: list.Concat([
	_filteredEthMethods,
	ethmethods.debugMethods,
	ethmethods.filterMethods,
	ethmethods.traceMethods,
	ethmethods.subscribeMethods,
	_bscTraceMethods,
	_bscWeb3Methods,
])

// Sort all BSC methods
#allBscMethods: (schema.#SortAndAddBit & {
	input: _allBsc
}).sorted

// Define the BSC Mainnet network
_bscMainnet: schema.#Network & {
	name:        "bsc"
	flavor:      "mainnet"
	description: "Bsc mainnet network"
	version:     "1.0.0"
	methods:     #allBscMethods
}

result: result & {
	bsc: mainnet: _bscMainnet
}
