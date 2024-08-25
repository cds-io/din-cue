package providers

import (
	C "acme.io/contracts/config"
	S "acme.io/contracts/schema"
)

_nodiesProvider: S.#Provider & {
	name: "Nectarine"
	meta: {
		description: "Nectarine"
	}
	services: (#GetServices & {
		input: C.#ProvidersConfig.nectarineProvider
	}).services
}

providers: providers & {
	"Nectarine": _nodiesProvider
}
