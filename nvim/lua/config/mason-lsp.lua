local on_attach = function(client, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	--vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	--vim.keymap.set("n", "K",  vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
	--vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	--vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<leader>fmt", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
end

require("mason-lspconfig").setup({
	ensure_installed = {
		"pyright",
		"rust_analyzer",
		"lua_ls",
		"bashls",
		"tsserver",
	},
})

-- for go
local lspconfig = require("lspconfig")
local configs = require("lspconfig/configs")

if not configs.golangcilsp then
	configs.golangcilsp = {
		default_config = {
			cmd = { "golangci-lint-langserver" },
			root_dir = lspconfig.util.root_pattern(".git", "go.mod"),
			init_options = {
				command = {
					"golangci-lint",
					"run",
					"--enable-all",
					"--disable",
					"lll",
					"--out-format",
					"json",
					"--issues-exit-code=1",
				},
			},
		},
	}
end
lspconfig.golangci_lint_ls.setup({
	filetypes = { "go", "gomod" },
})
local util = require("lspconfig/util")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig["gopls"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "gopls", "serve" },
	filetypes = { "go", "gomod" },
	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
})

-- for python
local virtual_env_path = vim.trim(vim.fn.system("poetry config virtualenvs.path"))
local virtual_env_dirctory = vim.trim(vim.fn.system("poetry env list"))
local python_path = "python"
if #vim.split(virtual_env_dirctory, "\n") == 1 then
	python_path = string.format("%s/%s/bin/python", virtual_env_path, virtual_env_dirctory)
end

lspconfig["pyright"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		python = {
			pythonPath = python_path,
		},
	},
})

lspconfig["ruff_lsp"].setup({
	on_attach = on_attach,
	init_options = {
		settings = {
			args = {},
		},
	},
})

-- for rust
lspconfig["rust_analyzer"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {
			checkOnSave = {
				command = "clippy",
			},
		},
	},
})

lspconfig["tsserver"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig["lua_ls"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

lspconfig["bashls"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
