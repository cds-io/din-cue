package providers

import (
	"acme.io/contracts/chains"
	"strings"
)

// Build a map of network and variant to network_uri, caps, and methods
// This is used to build the services for each provider, as most services
// are just a mapping of network and variant to network_uri, caps, and methods
// TODO: Revist this when providers serve a subset of methods.
_networkMap: {
	for network in chains.result {
		for _, v in network {
			"\(strings.ToLower(v.name))": "\(strings.ToLower(v.flavor))": {
				network_uri: v.rpc_uri
				caps:        v.caps
				methods:     v.methods
			}
		}
	}
}

// Function pattern to get services for a provider

// The input shape for the 
#LocalServicesInput: [string]: [string]: {
	// URL of the provider service, must be non-empty
	endpoint_details: url: string & !=""
	// Optional priority of the provider service, default is 0
	priority?: int | *0
	// Optional headers for the provider service
	headers?: {
		// TODO: define headers and cocnstraints
		[key=string]: string
	}
}

#GetServices: {
	input: #LocalServicesInput

	// Derive the services based on the input and the network map
	services: {
		for network, variants in input {
			(network): {
				for variant, details in variants {
					(variant): details & {
						network_uri: _networkMap[network][variant].network_uri
						caps:        _networkMap[network][variant].caps
						methods:     _networkMap[network][variant].methods
					}
				}
			}
		}
	}
}
