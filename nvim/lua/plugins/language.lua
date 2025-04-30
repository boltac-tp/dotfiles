return {
	{
		-- https://github.com/mrcjkb/rustaceanvim
		"mrcjkb/rustaceanvim",
		version = "^6",
		lazy = false,
		config = function()
			vim.g.rustaceanvim = {
				tools = {},
				server = {
					onattach = function(client, bufnr)
						vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
					end,
					defaultsettings = {
						["rust-analyzer"] = {
							imports = {
								granularity = {
									group = "module",
								},
							},
							checkOnSave = {
								command = "clippy",
							},
							typing = {
								autoClosingAngleBrackets = true,
							},
							completion = {
								autoimport = {
									enable = true,
								},
							},
							cargo = {
								buildScripts = {
									enable = true,
								},
							},
							procMacro = {
								enable = true,
							},
						},
					},
				},
				dap = {},
			}
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		ft = { "markdown" },
		---@module 'render-marksown'
		---@type render.md.UserConfig
		opts = {
			completions = { lsp = { enabled = true } },
			render_modes = true,
		},
	},
}
