package providers

import (
	"acme.io/contracts/chains"
	"acme.io/contracts/ethmethods"
	C "acme.io/contracts/config"
	S "acme.io/contracts/schema"
	"list"
)

// Falafel only serves ethereum mainnet debug and trace namespaces
_falMethods: list.FlattenN([ethmethods.debugMethods, ethmethods.traceMethods], 1)
_falMethods: _falMethods & [for m in _falMethods {bit: chains.#ethereumDict[m.name]}]
_falafel: S.#Provider & {
	name: "Falafel"
	services: {
		ethereum: {
			mainnet: {
				network_uri:      _networkMap.ethereum.mainnet.network_uri
				endpoint_details: C.#ProvidersConfig.falafel.ethereum.mainnet.endpoint_details

				// Derive mask from chain and the methods supported.
				caps: (S.#GetProviderMask & {
					chain:   chains.#allEthereumMethods
					methods: _falMethods
				}).mask

				methods: _falMethods
			}
		}
	}
}

providers: providers & {
	"Falafel": _falafel
}
