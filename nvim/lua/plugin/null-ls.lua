local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		-- gitsigns
		-- null_ls.builtins.code_actions.gitsigns,

		-- lua
		null_ls.builtins.formatting.stylua,

		-- python
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.isort,
		null_ls.builtins.diagnostics.flake8,

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
			prefer_local = "node_mofules/.bin",
		}),

		-- go
		null_ls.builtins.formatting.goimports,
	},
})
