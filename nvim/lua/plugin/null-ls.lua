local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	sources = {
		-- gitsigns
		-- null_ls.builtins.code_actions.gitsigns,

		-- lua
		null_ls.builtins.formatting.stylua,

		-- python
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.isort,
		null_ls.builtins.diagnostics.flake8.with({
			extra_args = { "--max-line-length=88", "--ignore=E203,W503,@504" },
		}),

		-- rust
		null_ls.builtins.formatting.rustfmt,

		-- typescript
		null_ls.builtins.formatting.deno_fmt.with({
			condition = function(utils)
				return not (utils.has_file({ ".prettierrc", "prettierrc.js", "deno.json", "deno.jsonc" }))
			end,
		}),
		null_ls.builtins.formatting.prettier.with({
			condition = function(utils)
				return utils.has_file({ ".prettierrc", ".prettierrc.js" })
			end,
			prefer_local = "node_modules/.bin",
		}),

		-- go
		null_ls.builtins.formatting.goimports,
	},

	-- format on save
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})
