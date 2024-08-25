package debug

import (
	"acme.io/contracts/ethmethods"
	"acme.io/contracts/chains"
	"list"
)

// This package is to help debug cue transformations
_data: chains.result



// The list of methods to exclude from the eth namespace
ethMethodsToExcludeForBsc: list.UniqueItems
x : [...ethmethods.#EthMethodNames]
ethMethodsToExcludeForBsc:  [
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
// filteredEthMethods: [
// 	for m in ethmethods.ethMethods
// 	if !list.Contains(ethMethodsToExcludeForBsc, m.name) {m},
// ]
