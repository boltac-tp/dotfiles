return {
	-- https://github.com/folke/lazydev.nvim
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ "nvim-dap-ui" },
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	-- https://github.com/kkharji/sqlite.lua
	{ "kkharji/sqlite.lua", lazy = true },
}
