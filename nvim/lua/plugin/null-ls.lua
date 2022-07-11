require("null-ls").setup({
	sources = {
		-- lua
		require("null-ls").builtins.formatting.stylua,
		-- python
		require("null-ls").builtins.formatting.black,
		require("null-ls").builtins.diagnostics.flake8,
		-- rust
		require("null-ls").builtins.formatting.rustfmt,
		-- typescript
		require("null-ls").builtins.formatting.deno_fmt.with({
			condition = function(utils)
				return not (utils.has_file({ ".prettierrc", "prettierrc.js", "deno.json", "deno.jsonc" }))
			end,
		}),
		require("null-ls").builtins.formatting.prettier.with({
			condition = function(utils)
				return utils.has_file({ ".prettierrc", ".prettierrc.js" })
			end,
			prefer_local = "node_mofules/.bin",
		}),
		require("null-ls").builtins.formatting.gofmt,
		require("null-ls").builtins.formatting.goimports,
	},
})
