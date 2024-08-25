package chains

import (
	"acme.io/contracts/schema"
	"acme.io/contracts/ethmethods"
	"list"
)

// borMethods for Polygon network
_borMethods: (#ToMethods & {
	_names: [
		"bor_getCurrentValidators",
		"bor_getRootHash",
		"bor_getSignersAtHash",
		"bor_getSnapshot",
	] & list.UniqueItems
	_ns: "bor"
}).methods

// txpool methods for Polygon network
_txpoolMethods: (#ToMethods & {
	_names: [
		"txpool_content",
		"txpool_inspect",
		"txpool_status",
	] & list.UniqueItems
	_ns: "txpool"
}).methods

// Combine all methods for Polygon network
_allPolygon: list.Concat([
	ethmethods.ethMethods,
	ethmethods.debugMethods,
	ethmethods.filterMethods,
	ethmethods.traceMethods,
	_borMethods,
	_txpoolMethods,
])

// Sort all Polygon methods
#allPolygonMethods: (schema.#SortAndAddBit & {
	input: _allPolygon
}).sorted

// Define the Polygon Mainnet network
_polygonMainnet: schema.#Network & {
	name:        "polygon"
	flavor:      "mainnet"
	description: "Polygon POS - An EVM enabled sidechain"
	version:     "1.0.0"
	methods:     #allPolygonMethods
}

// Define the Polygon Testnet network
_polygonTestnet: schema.#Network & {
	name:        "polygon"
	flavor:      "testnet"
	description: "Polygon POS - An EVM enabled sidechain"
	version:     "1.0.0"
	methods:     #allPolygonMethods
}

result: result & {
	polygon: mainnet: _polygonMainnet
	polygon: testnet: _polygonTestnet
}
