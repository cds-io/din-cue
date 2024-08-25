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
		Provider p = api.createProvider(theOwner, "Falafel");
		require(p.owner() == theOwner, "Ownership mismatch");
		uint256 initialCaps;
		console2.log("Create Managed Collection: [ethereum://mainnet]: 27021597764223006");
		// dec: 27021597764223006
		// hex: 6000000000001e
		// bin: 1100000000000000000000000000000000000000000000000011110
		initialCaps = 0x6000000000001e;
		api.createManagedCollection("ethereum://mainnet", initialCaps, p);
		vm.stopBroadcast();
	}
}