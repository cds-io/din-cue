package providers

import (
	C "acme.io/contracts/config"
	S "acme.io/contracts/schema"
)

_lycheeProvider: S.#Provider & {
	name: "Lychee"
	meta: {
		description: "Lychee"
	}
	services: (#GetServices & {
		input: C.#ProvidersConfig.lycheeProvider
	}).services
}

providers: providers & {
	"Lychee": _lycheeProvider
}
