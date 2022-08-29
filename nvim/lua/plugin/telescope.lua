require("telescope").setup({
	defaults = {
		mappings = {
			n = {
				["q"] = require("telescope.actions").close,
			},
		},
	},
	extensions = {
		file_browser = {
			hijack_netrw = true,
		},
	},
})

require("telescope").load_extension("file_browser")
