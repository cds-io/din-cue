package providers

import (
	C "acme.io/contracts/config"
	S "acme.io/contracts/schema"
)

_zheProvider: S.#Provider & {
	name: "Zhe"
	meta: {
		description: "Zhe"
	}
	services: (#GetServices & {
		input: C.#ProvidersConfig.zheProvider
	}).services
}

providers: providers & {
	"Zhe": _zheProvider
}
