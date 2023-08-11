require("mason-lspconfig").setup({
    ensure_installed = {
        --        "pyright",
        --		"rust_analyzer",
        "lua_ls",
        "bashls",
        "tsserver",
    },
})
