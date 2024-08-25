package chains

_endpointCollectionTemplate: """
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
				{{- range $index, $method := .methods }}
				{{- if $index }},{{- end }}
				"{{ $method.name }}"
				{{- end }}
			];
		}
	
		function setUp() public {
			theOwner = vm.envAddress("THE_ACCOUNT");
			api = Api(vm.envAddress("THE_CONTRACT"));
		}
	
		function run() external {
			vm.startBroadcast(theOwner);
	
			IEndpointCollection ec = api.createEndpointCollection("{{ .rpc_uri }}", "{{ .description }}");
			uint256 expectedCaps = {{ printf "0x%x" .caps }};
			uint256 onChainCaps = ec.addMethods(methods);
	
			// Verify the derived onChain CAPS match the expected value
			require(expectedCaps == onChainCaps, "CAPS mismatch");
	
			vm.stopBroadcast();
			console2.log("{{ .slug }}EndpointCollection deployed to: ", address(ec));
		}
	}
	"""
