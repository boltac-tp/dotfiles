-- rustacea
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
