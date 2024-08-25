package providers

import (
	C "acme.io/contracts/config"
	S "acme.io/contracts/schema"
)

_cherryProvider: S.#Provider & {
	name: "Cherry"
	meta: {
		description: "Cherry"
	}

	services: (#GetServices & {
		input: C.#ProvidersConfig.cherryProvider
	}).services
}

providers: providers & {
	"Cherry": _cherryProvider
}
