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
		Provider p = api.createProvider(theOwner, "Nectarine");
		require(p.owner() == theOwner, "Ownership mismatch");
		uint256 initialCaps;
		console2.log("Create Managed Collection: [blast://mainnet]: 1125899906842622");
		// dec: 1125899906842622
		// hex: 3fffffffffffe
		// bin: 11111111111111111111111111111111111111111111111110
		initialCaps = 0x3fffffffffffe;
		api.createManagedCollection("blast://mainnet", initialCaps, p);
		console2.log("Create Managed Collection: [blast://testnet]: 1125899906842622");
		// dec: 1125899906842622
		// hex: 3fffffffffffe
		// bin: 11111111111111111111111111111111111111111111111110
		initialCaps = 0x3fffffffffffe;
		api.createManagedCollection("blast://testnet", initialCaps, p);
		vm.stopBroadcast();
	}
}