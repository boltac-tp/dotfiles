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

lspconfig["ruff_lsp"].setup({
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
