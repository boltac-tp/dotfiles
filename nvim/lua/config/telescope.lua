local telescope = require("telescope")

telescope.setup({
	defaults = {
		mappings = {
			n = {
				["q"] = require("telescope.actions").close,
			},
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
		file_browser = {
			hijack_netrw = true,
		},
	},
})

telescope.load_extension("file_browser")
telescope.load_extension("ui-select")
