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
			"starknet_addDeclareTransaction",
			"starknet_addDeployAccountTransaction",
			"starknet_addInvokeTransaction",
			"starknet_blockHashAndNumber",
			"starknet_blockNumber",
			"starknet_call",
			"starknet_chainId",
			"starknet_estimateFee",
			"starknet_estimateMessageFee",
			"starknet_getBlockTransactionCount",
			"starknet_getBlockWithReceipts",
			"starknet_getBlockWithTxHashes",
			"starknet_getBlockWithTxs",
			"starknet_getClass",
			"starknet_getClassAt",
			"starknet_getClassHashAt",
			"starknet_getEvents",
			"starknet_getNonce",
			"starknet_getStateUpdate",
			"starknet_getStorageAt",
			"starknet_getTransactionByBlockIdAndIndex",
			"starknet_getTransactionByHash",
			"starknet_getTransactionReceipt",
			"starknet_getTransactionStatus",
			"starknet_simulateTransactions",
			"starknet_specVersion",
			"starknet_syncing",
			"starknet_traceBlockTransactions",
			"starknet_traceTransaction"
		];
	}

	function setUp() public {
		theOwner = vm.envAddress("THE_ACCOUNT");
		api = Api(vm.envAddress("THE_CONTRACT"));
	}

	function run() external {
		vm.startBroadcast(theOwner);

		IEndpointCollection ec = api.createEndpointCollection("starknet://mainnet", "Decentralized, permissionless and scalable Layer-2 network protocol developed by StarkWare for the Ethereum network.");
		uint256 expectedCaps = 0x3ffffffe;
		uint256 onChainCaps = ec.addMethods(methods);

		// Verify the derived onChain CAPS match the expected value
		require(expectedCaps == onChainCaps, "CAPS mismatch");

		vm.stopBroadcast();
		console2.log("StarknetMainnetEndpointCollection deployed to: ", address(ec));
	}
}