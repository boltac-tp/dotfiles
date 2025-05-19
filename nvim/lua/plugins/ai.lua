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
			"j-hui/fidget.nvim",
		},
		config = function()
			require("scripts.fidget-spinner"):init()

			local hostname = vim.uv.os_gethostname()
			local myadapter = "gemini"
			-- if hostname == "Melchior" then
			-- 	myadapter = "ollama"
			-- end

			require("codecompanion").setup({
				strategies = {
					chat = {
						adapter = myadapter,
						roles = {
							llm = function(adapter)
								return "  CodeCompanion (" .. adapter.formatted_name .. ")"
							end,
							user = "  Me",
						},
					},
					inline = { adapter = myadapter },
					cmd = { adapter = myadapter },
				},
				adapters = {
					gemini = function()
						return require("codecompanion.adapters").extend("gemini", {
							schema = {
								model = {
									default = "gemini-2.5-flash-preview-04-17",
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
									default = "qwen3:8b",
								},
							},
						})
					end,
				},
				opts = {
					language = "Japanese",
				},
				display = {
					chat = {
						auto_scroll = false,
						show_header_separator = true,
					},
				},
			})
		end,
	},
}
