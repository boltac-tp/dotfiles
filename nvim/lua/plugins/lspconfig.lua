return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local configs = require("lspconfig/configs")

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP:" .. desc })
					end

					map("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
					map("gr", require("telescope.builtin").lsp_references, "Goto References")
					map("gI", require("telescope.builtin").lsp_implementations, "Goto Implementations")
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type Definition")
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
					map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")

					map("gD", vim.lsp.buf.declaration, "Goto Declaration")
					map("<leader>rn", vim.lsp.buf.rename, "Rename")
					map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
					map("<leader>K", vim.lsp.buf.signature_help, "Signature Help")
					-- map("K", vim.lsp.buf.hover, "Hover")
					map("<leader>rs", "<cmd>LspRestart<CR>", "Lsp Restart")

					map("<leader>wa", vim.lsp.buf.add_workspace_folder, "Add Workspace Folder")
					map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder")
					map("<leader>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, "List Workspace Folders")

					--when move cursor,the highlight will be cleared
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup = vim.api.nvim_create_augroup("lsp_highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("lsp_detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "lsp_highlight", buffer = event2.buf })
							end,
						})
					end

					-- This may be unwanted, since they displace some of your code
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "Toggle Inlay Hints")
					end
				end,
			})

			--- server settings

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			lspconfig["lua_ls"].setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
							disable = { "missing-fields" },
						},
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			})
			lspconfig["jsonls"].setup({
				capabilities = capabilities,
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})
			lspconfig["yamlls"].setup({
				capabilities = capabilities,
				settings = {
					yaml = {
						schemaStore = {
							enable = false,
							url = "",
						},
						schemas = require("schemastore").yaml.schemas(),
					},
				},
			})
			lspconfig["pyright"].setup({ capabilities = capabilities })
			lspconfig["ruff"].setup({ capabilities = capabilities })
			lspconfig["vtsls"].setup({ capabilities = capabilities })
			lspconfig["biome"].setup({ capabilities = capabilities })
			lspconfig["taplo"].setup({ capabilities = capabilities })
			lspconfig["bashls"].setup({ capabilities = capabilities })
			lspconfig["dockerls"].setup({ capabilities = capabilities })
			lspconfig["docker_compose_language_service"].setup({ capabilities = capabilities })
			lspconfig["gopls"].setup({ capabilities = capabilities })
			lspconfig["golangci_lint_ls"].setup({ capabilities = capabilities })
			--lspconfig["hls"].setup({ capabilities = capabilities, filetypes = { "haskell", "lhaskell", "cabel" } })
		end,
	},
	-- https://github.com/b0o/SchemaStore.nvim
	{ "b0o/schemastore.nvim" },
}
