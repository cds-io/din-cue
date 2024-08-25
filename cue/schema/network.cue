package schema

import (
	Cfg "acme.io/contracts/config"
	"strings"
)

// Define the structure for returning network information
#NetworksConfig: {
	[chain=or(Cfg.#KnownNetworks)]: [variant=Cfg.#KnownVariants[chain]]: #Network & {
		name:   chain
		flavor: variant
	}
}

// Define the main structure of the RPC endpoints configuration
#Network: {
	// Name of the RPC endpoint, must be alphanumeric
	name: string & =~"^[a-zA-Z0-9]+$"
	// Description of the RPC endpoint, must be non-empty
	description: string & !=""
	// Version of the RPC endpoint, must be non-empty
	version: string & !=""
	// Flavor of the RPC endpoint, must be alphanumeric
	flavor: string & =~"^[a-zA-Z0-9]+$"
	// Automatically derive rpc_uri from the name and flavor properties
	rpc_uri: "\(strings.ToLower(name))://\(strings.ToLower(flavor))"
	// Namespaces within the RPC endpoint
	slug: "\(strings.ToTitle(name))\(strings.ToTitle(flavor))"
	// Derive network capacity
	caps: (#GetMask & {"methods": methods}).value
	// List of methods available in the RPC endpoint
	methods: #MethodList
}

// Define the list of methods
#MethodList: [...#Method]

// Define the structure of a method
#Method: {
	// Name of the method, must be non-empty
	name: string & !=""
	// Namespace of the method, must be non-empty
	ns:   string & !=""
	bit?: int
	// Optional description of the method
	description?: string
	// Optional list of parameters for the method
	parameters?: [...#Parameter]
	// Optional return value of the method
	returns?: #Return
}

// Define the structure of a parameter
#Parameter: {
	// Name of the parameter, must be non-empty
	name: string & !=""
	// Type of the parameter, must be non-empty
	type: string & !=""
	// Optional description of the parameter
	description?: string
}

// Define the structure of a return value
#Return: {
	// Type of the return value, must be non-empty
	type: string & !=""
	// Optional description of the return value
	description?: string
}
