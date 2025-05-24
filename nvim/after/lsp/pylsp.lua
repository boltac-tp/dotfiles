return {
	settings = {
		pylsp = {
			plugins = {
				pycodestyle = {
					ignore = { "W391" },
					max_line_length = 120,
				},
				rope_autoimport = {
					enabled = true,
				},
			},
		},
	},
}
