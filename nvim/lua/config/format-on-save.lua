local format_on_save = require("format-on-save")
local formatters = require("format-on-save.formatters")

format_on_save.setup({
	experiments = {
		partial_update = "diff",
	},
	exclude_path_patterns = {
		"/node_modules/",
	},
	formatter_by_ft = {
		css = formatters.lsp,
		html = formatters.lsp,
		javascript = formatters.lsp,
		json = formatters.lsp,
		lua = formatters.stylua,
		markdown = {
			formatters.prettierd,
			formatters.shell({
				cmd = { "markdown-toc", "-i", "%" },
				tempfile = function()
					return vim.fn.expand("%") .. ".markdown-top-temp"
				end,
			}),
		},
		python = formatters.black,
		rust = formatters.lsp,
		scss = formatters.lsp,
		sh = formatters.shfmt,
		typescript = formatters.eslint_d_fix,
		typescriptreact = formatters.eslint_d_fix,
		go = formatters.lsp,
		haskell = formatters.lsp,
		yaml = formatters.lsp,
	},
	fallback_formatter = {
		formatters.remove_trailing_whitespace,
	},
})
