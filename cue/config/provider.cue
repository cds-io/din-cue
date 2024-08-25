package config

#ProvidersConfig: {
	berryProvider: {
		polygon: {
			mainnet: endpoint_details: url: "https://polygon-mainnet.chocula.io:443/key"
			testnet: endpoint_details: url: "https://polygon-testnet.chocula.io:443/key"
		}

		optimism: {
			mainnet: endpoint_details: url: "https://optimism-mainnet.chocula.io:443/key"
			sepolia: endpoint_details: url: "https://optimism-sepolia.chocula.io:443/key"
		}

		starknet: {
			mainnet: endpoint_details: url: "https://starknet-mainnet.chocula.io:443/key"
			sepolia: endpoint_details: url: "https://starknet-sepolia.chocula.io:443/key"
		}
	}

	cherryProvider: {
		zksync:
			mainnet: endpoint_details: url: "https://nd-373-857-307.p2pify.com:443/key"
	}

	falafel: {
		ethereum:
			mainnet: endpoint_details: url: "https://eth.rpc.greasy-goodness.cloud:443/key"
	}

	loganProvider: {
		blast:
			mainnet: endpoint_details: {
				url:      "https://blast.logan.com:443/v1/eth/"
				priority: 0
				headers: {"x-api-key": "key"}
			}
	}

	lycheeProvider: {
		arbitrum:
			mainnet: endpoint_details: url: "https://india.lychee.com:443/api=key/arb"
		avalanchec:
			mainnet: endpoint_details: url: "https://india.lychee.com:443/api=key/avax"
	}

	nectarineProvider: {
		blast: {
			mainnet: {
				endpoint_details: {
					url:      "https://lb.nectarine.app:443/v1/key"
					priority: 1
				}
			}

			testnet: endpoint_details: url: "https://lb.nectarine.app:443/v1/blast-testnet-key"
		}
	}

	rambutanProvider: {
		ethereum: mainnet: endpoint_details: url: "https://eth.rpc.rambutan.cloud:443/key"
		polygon: mainnet: endpoint_details: url:  "https://polygon.rpc.rambutan.cloud:443/key"
	}

	zheProvider: {
		mantle: {
			mainnet: endpoint_details: {
				url: "https://mantle.dc01.zhe.io:443/"
				headers: "x-api-key": "key"
			}
			sepolia: endpoint_details: url: "https://sepolia.mantle.dc01.zhe.io:443/"
		}
	}
}
