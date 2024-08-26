package providers

import "encoding/yaml"

import "tool/file"

import "text/template"

args: {
	target_sol_dir: string | *"./build/sol/providers"  @tag(target_sol_dir)
	target_yml_dir: string | *"./build/conf/providers" @tag(target_yml_dir)
}

command: make: {
	for provider, pdata in providers {
		// make a unique name when comprehending
		(provider): {
			sol: {
				file.Create & {
					filename: "\(args.target_sol_dir)/\(pdata.name)Provider.sol"
					contents: template.Execute(_solidityTemplate, pdata)
				}
			}

			yml: {
				file.Create & {
					filename: "\(args.target_yml_dir)/\(pdata.name)Provider.yml"
					contents: yaml.Marshal(pdata)
				}
			}
		}
	}
}
