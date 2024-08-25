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
			"eth_getUncleByBlockHashAndIndex",
			"eth_getUncleCountByBlockHash",
			"eth_getUncleCountByBlockNumber",
			"eth_maxPriorityFeePerGas",
			"eth_protocolVersion",
			"eth_sendRawTransaction",
			"eth_syncing",
			"net_listening",
			"net_peerCount",
			"net_version",
			"web3_clientVersion",
			"web3_sha3"
		];
	}

	function setUp() public {
		theOwner = vm.envAddress("THE_ACCOUNT");
		api = Api(vm.envAddress("THE_CONTRACT"));
	}

	function run() external {
		vm.startBroadcast(theOwner);

		IEndpointCollection ec = api.createEndpointCollection("mantle://mainnet", "Mantle mainnet network");
		uint256 expectedCaps = 0x7fffffffe;
		uint256 onChainCaps = ec.addMethods(methods);

		// Verify the derived onChain CAPS match the expected value
		require(expectedCaps == onChainCaps, "CAPS mismatch");

		vm.stopBroadcast();
		console2.log("MantleMainnetEndpointCollection deployed to: ", address(ec));
	}
}