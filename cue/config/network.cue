package config

// List of known networks
#KnownNetworks: [
	"arbitrum",
	"avalanchec",
	"blast",
	"bsc",
	"ethereum",
	"mantle",
	"optimism",
	"polygon",
	"starknet",
	"zksync",
]

#KnownVariants: {
	arbitrum: or(["mainnet"])
	avalanchec: or(["mainnet"])
	blast: or(["mainnet", "testnet"])
	bsc: or(["mainnet"])
	ethereum: or(["mainnet", "sepolia", "goerli"])
	mantle: or(["mainnet", "sepolia"])
	optimism: or(["mainnet", "sepolia"])
	polygon: or(["mainnet", "testnet"])
	starknet: or(["mainnet", "sepolia"])
	zksync: or(["mainnet", "sepolia"])
}
