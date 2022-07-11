local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "vsnip" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "nvim_lsp_document_symbol" },
		{ name = "path" },
		{ name = "nvim_lua" },
		{ name = "treesitter" },
		{ name = "cmdline" },
	}, {
		{ name = "buffer" },
	}),
})

cmp.setup.cmdline("/", {
	sources = cmp.config.sources({
		{ name = "nvim_lsp_document_symbol" },
	}, {
		{ name = "buffer" },
	}),
	mapping = cmp.mapping.preset.cmdline(),
})

cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
	mapping = cmp.mapping.preset.cmdline(),
})

-- local cmp_autopairs = require "nvim-autopairs.completion.cmp"
-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done {})
