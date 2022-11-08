local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	-- LSPサーバーのフォーマット機能を無効にする
	client.server_capabilities.documentFormattingProvider = false

	local opts = { noremap = true, silent = true }
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	--buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	--buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	--buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	--buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	--buf_set_keymap("n", "<space>d", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	--buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	--buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
	buf_set_keymap("n", "<leader>fmt", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
end

require("mason-lspconfig").setup({
	ensure_installed = {
		-- python
		"pyright",
--		"black",
--		"flake8",
--		"isort",
		-- rust
		"rust_analyzer",
		-- lua
		"sumneko_lua",
--		"stylua",
		-- go
		"gopls",
--		"goimports",
		-- shell
		"bashls",
		-- javascript
		"tsserver",
	},
})
local lspconfig = require("lspconfig")
local util = require("lspconfig/util")

-- for python
local virtual_env_path = vim.trim(vim.fn.system("poetry config virtualenvs.path"))
local virtual_env_dirctory = vim.trim(vim.fn.system("poetry env list"))

local python_path = "python"
if #vim.split(virtual_env_dirctory, "\n") == 1 then
	python_path = string.format("%s/%s/bin/python", virtual_env_path, virtual_env_dirctory)
end

lspconfig["pyright"].setup({
	on_attach = on_attach,
	settings = {
		python = {
			pythonPath = python_path,
		},
	},
})

-- for rust
lspconfig["rust_analyzer"].setup({
	on_attach = on_attach,
	settings = {
		["rust-analyzer"] = {
			checkOnSave = {
				command = "clippy",
			},
		},
	},
})

-- for golang
lspconfig["gopls"].setup({
	on_attach = on_attach,
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

lspconfig["tsserver"].setup({
	on_attach = on_attach,
})


lspconfig["sumneko_lua"].setup({
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})


lspconfig["bashls"].setup({})
