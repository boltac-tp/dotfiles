return {
	-- https://github.com/stevearc/conform.nvim
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>fm",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			go = { "goimports", "gofmt" },
			javascript = { "biome" },
			javascriptreact = { "biome" },
			typescript = { "biome" },
			typescriptreact = { "biome" },
			sh = { "shfmt" },
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
		format_on_save = {
			lsp_format = "fallback",
			timeout_ms = 500,
		},
		format_after_save = {
			lsp_format = "fallback",
		},
		log_level = vim.log.levels.ERROR,
		notify_on_error = true,
		notyfy_no_formatters = true,
	},
}
