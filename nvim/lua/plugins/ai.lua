return {
	{
		-- https://github.com/sourcegraph/sg.nvim
		"sourcegraph/sg.nvim",
		event = "LspAttach",
		opts = {},
	},
	{
		-- https://github.com/Exafunction/windsurf.nvim
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
		config = function()
			-- local hostname = vim.uv.os_gethostname()
			local myadapter = "gemini"
			-- if hostname == "Melchior" then
			-- 	myadapter = "ollama"
			-- end

			require("codecompanion").setup({
				strategies = {
					chat = { adapter = myadapter },
					inline = { adapter = myadapter },
					cmd = { adapter = myadapter },
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
					ollama = function()
						return require("codecompanion.adapters").extend("ollama", {
							schema = {
								model = {
									default = "gemma3:12b",
								},
							},
						})
					end,
				},
				opts = {
					language = "Japanese",
				},
			})
		end,
	},
}
