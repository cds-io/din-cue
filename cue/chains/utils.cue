package chains

import "list"

import "acme.io/contracts/schema"

// Function pattern 
// @param names : a list of string methods
// @param ns : the namespace 
// @output methods
#ToMethods: {
	_names: [...string]
	_names: list.UniqueItems
	_ns:    string

	// output
	methods: schema.#MethodList & [
		for m in _names {name: m, ns: _ns},
	]
}
