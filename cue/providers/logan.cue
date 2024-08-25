package providers

import (
	C "acme.io/contracts/config"
	S "acme.io/contracts/schema"
)

_loganProvider: S.#Provider & {
	name: "Logan"
	meta: {
		description: "Logan"
	}
	services: (#GetServices & {
		input: C.#ProvidersConfig.loganProvider
	}).services
}

providers: providers & {
	"Logan": _loganProvider
}
