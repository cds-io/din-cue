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
		Provider p = api.createProvider(theOwner, "Berry");
		require(p.owner() == theOwner, "Ownership mismatch");
		uint256 initialCaps;
		console2.log("Create Managed Collection: [optimism://mainnet]: 562949953421310");
		// dec: 562949953421310
		// hex: 1fffffffffffe
		// bin: 1111111111111111111111111111111111111111111111110
		initialCaps = 0x1fffffffffffe;
		api.createManagedCollection("optimism://mainnet", initialCaps, p);
		console2.log("Create Managed Collection: [optimism://sepolia]: 562949953421310");
		// dec: 562949953421310
		// hex: 1fffffffffffe
		// bin: 1111111111111111111111111111111111111111111111110
		initialCaps = 0x1fffffffffffe;
		api.createManagedCollection("optimism://sepolia", initialCaps, p);
		console2.log("Create Managed Collection: [polygon://mainnet]: 4611686018427387902");
		// dec: 4611686018427387902
		// hex: 3ffffffffffffffe
		// bin: 11111111111111111111111111111111111111111111111111111111111110
		initialCaps = 0x3ffffffffffffffe;
		api.createManagedCollection("polygon://mainnet", initialCaps, p);
		console2.log("Create Managed Collection: [polygon://testnet]: 4611686018427387902");
		// dec: 4611686018427387902
		// hex: 3ffffffffffffffe
		// bin: 11111111111111111111111111111111111111111111111111111111111110
		initialCaps = 0x3ffffffffffffffe;
		api.createManagedCollection("polygon://testnet", initialCaps, p);
		console2.log("Create Managed Collection: [starknet://mainnet]: 1073741822");
		// dec: 1073741822
		// hex: 3ffffffe
		// bin: 111111111111111111111111111110
		initialCaps = 0x3ffffffe;
		api.createManagedCollection("starknet://mainnet", initialCaps, p);
		console2.log("Create Managed Collection: [starknet://sepolia]: 1073741822");
		// dec: 1073741822
		// hex: 3ffffffe
		// bin: 111111111111111111111111111110
		initialCaps = 0x3ffffffe;
		api.createManagedCollection("starknet://sepolia", initialCaps, p);
		vm.stopBroadcast();
	}
}