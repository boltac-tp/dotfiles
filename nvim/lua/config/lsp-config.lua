-- variables
local lspconfig = require("lspconfig")
local configs = require("lspconfig/configs")
local s = vim.keymap.set

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
		--    s("n", "gD", vim.lsp.buf.declaration, opts)
		--    s('n', 'gd', vim.lsp.buf.definition, opts)
		--    s('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		s("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
		s("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
		s("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		--    s("n", "<leader>D", vim.lsp.buf.type_definition, opts)
		--    s('n', '<leader>rn', vim.lsp.buf.rename, opts)
		--    s({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
		s("n", "gr", vim.lsp.buf.references, opts)
		s("n", "<leader>fmt", function()
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

lspconfig["pyright"].setup({
	settings = {},
})

lspconfig["ruff_lsp"].setup({
	settings = {
		args = { "--config=~/.config/ruff/ruff.toml" },
	},
})

-- for rust
lspconfig["rust_analyzer"].setup({
	settings = {
		["rust-analyzer"] = {
			checkOnSave = {
				command = "clippy",
			},
			typing = {
				autoClosingAngleBrackets = "true",
			},
			completion = {
				autoimport = "enable",
			},
		},
	},
})

lspconfig["tsserver"].setup({
	settings = {
		filetypes = {
			"typescript",
			"typescriptreact",
			"tipescript.tsx",
		},
		cmd = {
			"typescript-language-server",
			"--stdio",
		},
	},
})

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

lspconfig["dockerls"].setup({})
lspconfig["docker_compose_language_service"].setup({})

lspconfig["hls"].setup({
	filetypes = { "haskell", "lhaskell", "cabal" },
})
