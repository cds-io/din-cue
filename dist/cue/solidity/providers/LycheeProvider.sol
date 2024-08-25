// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

// TODO: fragile import path
import "../../../Api.sol";

import {Script} from "forge-std/Script.sol";
import {console2} from "forge-std/console2.sol";

contract Deploy is Script {
	Api api;
	address theOwner;

	function run() external {
		theOwner = vm.envAddress("THE_OWNER");
		api = Api(vm.envAddress("THE_CONTRACT"));

		console2.log("API address: ", address(api));
		console2.log("API owner: ", theOwner);

		// Interact with the contract here
		vm.startBroadcast(theOwner);
		console2.log("Start bcast");
		Provider p = api.createProvider(theOwner, "Lychee");
		require(p.owner() == theOwner, "Ownership mismatch");
		uint256 initialCaps;
		console2.log("Create Managed Collection: [arbitrum://mainnet]: 144115188075855870");
		// dec: 144115188075855870
		// hex: 1fffffffffffffe
		// bin: 111111111111111111111111111111111111111111111111111111110
		initialCaps = 0x1fffffffffffffe;
		api.createManagedCollection("arbitrum://mainnet", initialCaps, p);
		console2.log("Create Managed Collection: [avalanchec://mainnet]: 9007199254740990");
		// dec: 9007199254740990
		// hex: 1ffffffffffffe
		// bin: 11111111111111111111111111111111111111111111111111110
		initialCaps = 0x1ffffffffffffe;
		api.createManagedCollection("avalanchec://mainnet", initialCaps, p);
		vm.stopBroadcast();
	}
}