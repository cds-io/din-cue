package chains

import "tool/file"

import "text/template"

import "encoding/yaml"

// Define the structure of arguments
args: {
	target_yml_dir: string | *"./build/conf/chains" @tag(target_yml_dir)
	target_sol_dir: string | *"./build/sol"         @tag(target_sol_dir)
}

// Iterate over the result structure and generate tasks
command: make: {
	// Iterate over each network in the result
	for network, variants in result {
		// Iterate over each variant of the network
		for variant, data in variants {
			// Task for creating YAML file for each variant
			"yml-\(network)-\(variant)": {
				write: file.Create & {
					filename: "\(args.target_yml_dir)/\(data.slug).yml"
					contents: yaml.Marshal(data)
				}
			}
			// Task for creating Solidity file for each variant
			"sol-\(network)-\(variant)": {
				write: file.Create & {
					filename: "\(args.target_sol_dir)/chains/\(data.slug)EndpointCollection.sol"
					contents: template.Execute(
							_endpointCollectionTemplate,
							data,
							)
				}
			}
		}
	}
}
