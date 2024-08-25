package schema

import (
	Cfg "acme.io/contracts/config"
)

// Define the structure for provider service definitions
#ProviderServiceDefinition: {
	// Network URI
	network_uri: string
	// Details of the endpoint
	endpoint_details: {
		// URL of the provider service, must be non-empty
		url: string & !=""
		// Optional priority of the provider service, default is 0
		priority?: int | *0
		// Optional headers for the provider service
		headers?: {
			[key=string]: string
		}
	}
	// Capacity mask
	caps!: int
	// List of methods provided
	methods!: #MethodList
}

// Define the structure for a provider
#Provider: {
	// Name of the provider, must be non-empty
	name: string & !=""
	// Optional metadata for the provider
	meta?: {
		description: string & !=""

		// leave room for more metadata fields here
		...
	}
	// List of services provided by the provider
	services: {
		[or(Cfg.#KnownNetworks)]: {
			[key=string]: #ProviderServiceDefinition
		}
	}
}
