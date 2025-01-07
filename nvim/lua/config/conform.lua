require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff" },
		go = { "goimports", "gofmt" },
		javascript = { "biome" },
		typescript = { "biome" },
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
})
