return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufRead", "InsertEnter" },
	dependencies = { "yioneko/nvim-yati" },
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = "all",
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_hilighting = false,
			},
			yati = { enable = true },
		})
	end,
}
