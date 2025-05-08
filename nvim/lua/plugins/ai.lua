return {
	{
		-- https://github.com/sourcegraph/sg.nvim
		"sourcegraph/sg.nvim",
		event = "LspAttach",
		opts = {},
	},
	{
		"Exafunction/windsurf.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({})
		end,
	},
	{
		-- https://github.com/olimorris/codecompanion.nvim
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			strategies = {
				chat = { adapter = "gemini" },
				inline = { adapter = "gemini" },
				cmd = { adapter = "gemini" },
			},
			adapters = {
				gemini = function()
					return require("codecompanion.adapters").extend("gemini", {
						schema = {
							model = {
								default = "gemini-2.5-pro-exp-03-25",
							},
						},
						env = {
							api_key = vim.env.GEMINI_APIKEY,
						},
					})
				end,
			},
			opts = {
				language = "Japanese",
			},
		},
	},
}
