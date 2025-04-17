return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufRead", "InsertEnter" },
	dependencies = { "yioneko/nvim-yati" },
	opts = {
		ensure_installed = "all",
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_hilighting = false,
		},
		yati = { enable = true },
	},
}
