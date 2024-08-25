// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {Script, console2} from "forge-std/Script.sol";

// TODO: fragile import path
import "../../../Api.sol";

contract Deploy is Script {
	Api api;
	address theOwner;
	string[] methods;

	constructor() {
		methods = [
			"debug_traceBlockByHash",
			"debug_traceBlockByNumber",
			"debug_traceCall",
			"debug_traceTransaction",
			"eth_accounts",
			"eth_blockNumber",
			"eth_call",
			"eth_chainId",
			"eth_estimateGas",
			"eth_gasPrice",
			"eth_getBalance",
			"eth_getBlockByHash",
			"eth_getBlockByNumber",
			"eth_getBlockReceipts",
			"eth_getBlockTransactionCountByHash",
			"eth_getBlockTransactionCountByNumber",
			"eth_getCode",
			"eth_getFilterS.anges",
			"eth_getLogs",
			"eth_getProof",
			"eth_getStorageAt",
			"eth_getTransactionByBlockHashAndIndex",
			"eth_getTransactionByBlockNumberAndIndex",
			"eth_getTransactionByHash",
			"eth_getTransactionCount",
			"eth_getTransactionReceipt",
			"eth_getUncleByBlockHashAndIndex",
			"eth_getUncleByBlockNumberAndIndex",
			"eth_maxPriorityFeePerGas",
			"eth_newBlockFilter",
			"eth_newFilter",
			"eth_newPendingTransactionFilter",
			"eth_sendRawTransaction",
			"eth_sendTransaction",
			"eth_subscribe",
			"eth_syncing",
			"eth_uninstallFilter",
			"eth_unsubscribe",
			"net_listening",
			"net_peerCount",
			"net_version",
			"trace_block",
			"trace_call",
			"trace_callMany",
			"trace_get",
			"trace_replayBlockTransactions",
			"trace_replayTransaction",
			"trace_transaction",
			"web3_clientversion",
			"web3_sha3"
		];
	}

	function setUp() public {
		theOwner = vm.envAddress("THE_ACCOUNT");
		api = Api(vm.envAddress("THE_CONTRACT"));
	}

	function run() external {
		vm.startBroadcast(theOwner);

		IEndpointCollection ec = api.createEndpointCollection("bsc://mainnet", "Bsc mainnet network");
		uint256 expectedCaps = 0x7fffffffffffe;
		uint256 onChainCaps = ec.addMethods(methods);

		// Verify the derived onChain CAPS match the expected value
		require(expectedCaps == onChainCaps, "CAPS mismatch");

		vm.stopBroadcast();
		console2.log("BscMainnetEndpointCollection deployed to: ", address(ec));
	}
}