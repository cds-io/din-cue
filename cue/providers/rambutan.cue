package providers

import (
	C "acme.io/contracts/config"
	S "acme.io/contracts/schema"
)

_rambutanProvider: S.#Provider & {
	name: "Rambutan"
	meta: {
		description: "Rambutan"
	}
	services: (#GetServices & {
		input: C.#ProvidersConfig.rambutanProvider
	}).services
}

providers: providers & {
	"Rambutan": _rambutanProvider
}
