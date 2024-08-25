package ethmethods

import (
	"list"
	"acme.io/contracts/schema"
)

// Type (disjunctions) definitions for reference names.
#EthMethodNames: [...or(#MethodDict.eth)]
#DebugMethodNames: [...or(#MethodDict.debug)]
#FilterMethodNames: [...or(#MethodDict.filter)]
#TraceMethodNames: [...or(#MethodDict.trace)]
#SubscribeMethodNames: [...or(#MethodDict.subscribe)]

// Derive MethodList for each namespace
ethMethods: schema.#MethodList & [for m in #MethodDict.eth {name: m, ns: "eth"}]
debugMethods: schema.#MethodList & [for m in #MethodDict.debug {name: m, ns: "debug"}]
filterMethods: schema.#MethodList & [for m in #MethodDict.filter {name: m, ns: "filter"}]
traceMethods: schema.#MethodList & [for m in #MethodDict.trace {name: m, ns: "trace"}]
subscribeMethods: schema.#MethodList & [for m in #MethodDict.subscribe {name: m, ns: "subscribe"}]

_namespaces: ["eth", "debug", "filter", "trace", "subscribe"] & list.UniqueItems
#MethodDict: {[or(_namespaces)]: [...string]}
#MethodDict: {
	eth: [
		"eth_accounts",
		"eth_blockNumber",
		"eth_call",
		"eth_chainId",
		"eth_coinbase",
		"eth_createAccessList",
		"eth_estimateGas",
		"eth_feeHistory",
		"eth_gasPrice",
		"eth_getBalance",
		"eth_getBlockByHash",
		"eth_getBlockByNumber",
		"eth_getBlockTransactionCountByHash",
		"eth_getBlockTransactionCountByNumber",
		"eth_getCode",
		"eth_getLogs",
		"eth_getProof",
		"eth_getStorageAt",
		"eth_getTransactionByBlockHashAndIndex",
		"eth_getTransactionByBlockNumberAndIndex",
		"eth_getTransactionByHash",
		"eth_getTransactionCount",
		"eth_getTransactionReceipt",
		"eth_getBlockReceipts",
		"eth_getUncleByBlockHashAndIndex",
		"eth_getUncleByBlockNumberAndIndex",
		"eth_getUncleCountByBlockHash",
		"eth_getUncleCountByBlockNumber",
		"eth_getWork",
		"eth_hashrate",
		"eth_maxPriorityFeePerGas",
		"eth_mining",
		"eth_protocolVersion",
		"eth_sendRawTransaction",
		"eth_sendTransaction",
		"eth_sign",
		"eth_submitWork",
		"eth_syncing",
		"net_listening",
		"net_peerCount",
		"net_version",
		"web3_clientVersion",
		"web3_sha3",
	]

	debug: [
		"debug_traceBlockByHash",
		"debug_traceBlockByNumber",
		"debug_traceCall",
		"debug_traceTransaction",
	]

	filter: [
		"eth_getFilterS.anges",
		"eth_newBlockFilter",
		"eth_newFilter",
		"eth_newPendingTransactionFilter",
		"eth_uninstallFilter",
	]

	trace: [
		"trace_block",
		"trace_transaction",
	]

	subscribe: [
		"eth_subscribe",
		"eth_unsubscribe",
	]
}
