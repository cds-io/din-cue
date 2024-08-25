package providers

import (
	C "acme.io/contracts/config"
)

_berryProvider: {
	name: "Berry"
	meta: {
		description: "Berry"
	}
	services: (#GetServices & {
		input: C.#ProvidersConfig.berryProvider
	}).services
}

providers: providers & {
	"Berry": _berryProvider
}
