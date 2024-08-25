package schema

import (
	"list"
	"math/bits"
)

// Define the sorting predicate for methods
#MethodSortPredicate: {
	x: #Method
	y: #Method
	// Predicate to determine the sorting order
	less: x.name < y.name
}

#SortMethods: {
	// Input is a list of list of lists
	methods: #MethodList
	// Flatten input at 1 depth
	flat: list.FlattenN(methods, 1)
	// Enforce unique constraint
	uniq: list.UniqueItems
	uniq: flat
	// Result is a unique list in ascending sort order
	sorted: list.Sort(uniq, #MethodSortPredicate)
}

#MakeMethodDict: {
	input: #MethodList
	dict: {for m in input {
		"\(m.name)": m.bit
		"\(m.bit)":  m.name
	}}
}

// Define the structure for sorting a list of items
#SortAndAddBit: {
	// Input is a list of list of lists
	input:   #MethodList
	_sorted: (#SortMethods & {methods: input}).sorted

	// add bit position to each method
	sorted: _sorted & [for i, _ in _sorted {bit: i + 1}]

	// Make a dictionary of bit to method
	dict: (#MakeMethodDict & {input: sorted}).dict
}

// Define the structure for calculating network capacity mask
#GetMask: {
	methods: #MethodList
	_units: [for i, _ in methods {bits.Lsh(1, i+1)}]
	value: list.Sum(_units)
}

// Define the structure for calculating provider capacity mask
#GetProviderMask: {
	chain:   #MethodList
	methods: #MethodList
	_dict: {for i, m in chain {"\(m.name)": bits.Lsh(1, i+1)}}
	_units: [for m in methods {_dict[m.name]}]
	// Sum up the units to get the final bitmask
	mask: list.Sum(_units)
}
