-- variables
local lspconfig = require("lspconfig")
local configs = require("lspconfig/configs")
local s = vim.keymap.set
local capabilities = require("cmp_nvim_lsp").default_capabilities()

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

        opts.desc = "LSP go to declaration"
        s("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "LSP show lsp definitions"
        s("n", "gd", vim.lsp.buf.definition, opts)

        opts.desc = "LSP show lsp implementations"
        s("n", "gi", vim.lsp.buf.implementation, opts)

        opts.desc = "LSP type definition"
        s("n", "gt", vim.lsp.buf.type_definition, opts)

        opts.desc = "LSP see available code actions"
        s({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "LSP show definition references"
        s("n", "gr", vim.lsp.buf.references, opts)

        opts.desc = "LSP show signature help"
        s("n", "<C-k>", vim.lsp.buf.signature_help, opts)

        opts.desc = "LSP show documetation for what is under cursor"
        s("n", "K", vim.lsp.buf.hover, opts)
        opts.desc = "LSP restart LSP"
        s("n", "<leader>rs", "<cmd>LspRestart<CR>", opts)

        opts.desc = "LSP add workspace"
        s("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)

        opts.desc = "LSP remove workspace"
        s("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)

        opts.desc = "LSP show workspace list"
        s("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)

        opts.desc = "LSP rename"
        s("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "LSP format"
        s("n", "<leader><leader>", function()
            vim.lsp.buf.format({ async = true })
        end, opts)
    end,
})

-- for go
local util = require("lspconfig/util")

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
    capabilities = capabilities,
    filetypes = { "go", "gomod" },
})

lspconfig["gopls"].setup({
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

lspconfig["pyright"].setup({
    capabilities = capabilities,
    settings = {},
})

lspconfig["ruff"].setup({
    capabilities = capabilities,
    settings = {},
})

-- for typescript

lspconfig["vtsls"].setup({
    capabilities = capabilities,
})
lspconfig["biome"].setup({
    capabilities = capabilities,
})

-- others

lspconfig["lua_ls"].setup({
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})

lspconfig["hls"].setup({
    capabilities = capabilities,
    filetypes = { "haskell", "lhaskell", "cabal" },
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

lspconfig["taplo"].setup({
    capabilities = capabilities,
})

lspconfig["bashls"].setup({
    capabilities = capabilities,
})
lspconfig["dockerls"].setup({
    capabilities = capabilities,
})
lspconfig["docker_compose_language_service"].setup({
    capabilities = capabilities,
})
