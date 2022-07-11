require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	highlight = {
		enable = true,
		additional_vim_regex_hilighting = false,
	},
	yati = { enable = true },
})
