-- variables
local lspconfig = require("lspconfig")
local configs = require("lspconfig/configs")
local s = vim.keymap.set

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>d", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		--    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		--    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
		--    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		--    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<leader>fmt", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})

-- for go
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
	settings = {
		python = {
			pythonPath = python_path,
		},
	},
})

-- for rust
lspconfig["rust_analyzer"].setup({
	capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {
			checkOnSave = {
				command = "clippy",
			},
		},
	},
})

lspconfig["tsserver"].setup({})

lspconfig["lua_ls"].setup({
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

lspconfig["bashls"].setup({})
