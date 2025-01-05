-- Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable", -- latest stable release
        lazyrepo,
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -------------------------------------------------
    -- color scheme                                --
    -------------------------------------------------
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme tokyonight-moon]])
        end,
    },
    -------------------------------------------------
    -- init                                        --
    -------------------------------------------------
    {
        "williamboman/mason.nvim",
        cmd = {
            "Mason",
            "MasonInstall",
            "MasonUninstall",
            "MasonUninstallAll",
            "MasonLog",
            "MasonUpdate",
            "MasonUpdateAll",
        },
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_uninstalled = "✗",
                    package_pending = "⟳",
                },
            },
        },
        config = function()
            require("mason").setup()
        end,
        build = ":MasonUpdate",
    },
    {
        "vim-jp/vimdoc-ja",
        lazy = true,
        keys = { {
            "h",
            mode = "c",
        } },
        -- ft = { "help" },
    },
    -------------------------------------------------
    -- utility                                     --
    -------------------------------------------------
    -- terminal
    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("config/toggleterm")
        end,
    }, -- filer
    {
        "kyazdani42/nvim-tree.lua",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        keys = {
            {
                "<leader>e",
                "<cmd>NvimTreeToggle<CR>",
                noremap = true,
                silent = true,
                desc = "NvimTreeToggle",
            },
        },
        config = function()
            require("nvim-tree").setup()
        end,
    },
    -------------------------------------------------
    -- completion                                  --
    -------------------------------------------------
    -- auto brackets/tag
    {
        "windwp/nvim-autopairs",
        event = { "InsertEnter" },
        config = function()
            require("nvim-autopairs").setup({
                enable_check_bracket_line = false,
            })
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },
    {
        "onsails/lspkind.nvim",
        config = function()
            require("config/lspkind-nvim")
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            "L3MON4D3/LuaSnip",
            "windwp/nvim-autopairs",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-emoji",
            "f3fora/cmp-spell",
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
            "ray-x/cmp-treesitter",
            "lukas-reineke/cmp-under-comparator",
        },
        config = function()
            require("config/nvim-cmp")
        end,
    },
    -------------------------------------------------
    -- LSP                                         --
    -------------------------------------------------
    --
    {
        "williamboman/mason-lspconfig.nvim",
        cmd = { "LspInstall", "LspUninstall" },
        config = function()
            require("config/mason-lsp")
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "williamboman/mason-lspconfig.nvim" },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("config/lsp-config")
        end,
    },
    {
        "j-hui/fidget.nvim",
        event = "LspAttach",
    },
    -- treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufRead", "InsertEnter" },
        dependencies = { { "yioneko/nvim-yati" } },
        config = function()
            require("config/treesitter")
        end,
    },
    -- formatting
    {
        "nvimtools/none-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("config/null-ls")
        end,
    },
    -- schema
    {
        "b0o/schemastore.nvim",
    },
    -------------------------------------------------
    -- dap                                         --
    -------------------------------------------------
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            require("dapui").setup()
        end,
    },
    {
        "mfussenegger/nvim-dap-python",
        config = function()
            require("config/nvim-dap-python")
        end,
    },
    -------------------------------------------------
    -- fazzy finder                                --
    -------------------------------------------------
    {
        "nvim-telescope/telescope.nvim",
        cmd = { "Telescope" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-treesitter/nvim-treesitter" },
            { "kyazdani42/nvim-web-devicons" },
            { "nvim-telescope/telescope-file-browser.nvim" },
            { "nvim-telescope/telescope-ui-select.nvim" },
        },
        config = function()
            require("config/telescope")
        end,
    },
    {
        "prochri/telescope-all-recent.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "kkharji/sqlite.lua",
            "stevearc/dressing.nvim",
        },
        opts = {},
    },
    -------------------------------------------------
    -- snipet                                      --
    -------------------------------------------------
    {
        "L3MON4D3/LuaSnip",
        config = function()
            require("config/luasnip")
        end,
    },
    {
        "benfowler/telescope-luasnip.nvim",
        config = function()
            require("telescope").load_extension("luasnip")
        end,
    },
    -------------------------------------------------
    -- actions                                     --
    -------------------------------------------------
    -- nvim-flash.nvim
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash",
            },
            {
                "S",
                mode = { "n", "o", "x" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter",
            },
            {
                "r",
                mode = "o",
                function()
                    require("flash").remote()
                end,
                desc = "Remote Flash",
            },
            {
                "R",
                mode = { "o", "x" },
                function()
                    require("flash").treesitter_search()
                end,
                desc = "Treesitter Search",
            },
            {
                "<c-s>",
                mode = { "c" },
                function()
                    require("flash").toggle()
                end,
                desc = "Toggle Flash Search",
            },
        },
    },
    -- nvim-surround
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup()
        end,
    },
    -- comment
    {
        "numToStr/Comment.nvim",
        lazy = false,
        config = function()
            require("Comment").setup()
        end,
    },
    -------------------------------------------------
    -- visual                                      --
    -------------------------------------------------
    -- gitsigns
    {
        "lewis6991/gitsigns.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("config/gitsigns")
        end,
    },
    -- indent
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPre", "BufNewFile" },
        main = "ibl",
        ops = {},
        config = function()
            require("ibl").setup()
        end,
    },
    {
        "norcalli/nvim-colorizer.lua",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("colorizer").setup({ "*" })
        end,
    },
    -- status line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        config = function()
            require("config/lualine")
        end,
    },
    -- buffer line
    {
        "akinsho/bufferline.nvim",
        dependencies = "kyazdani42/nvim-web-devicons",
        config = function()
            require("bufferline").setup({
                options = {
                    always_show_bufferline = true,
                },
            })
        end,
    },
    -- noice
    {
        "folke/noice.nvim",
        dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
        event = "VeryLazy",
        config = function()
            require("noice").setup()
        end,
    },
    -- which key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
    -------------------------------------------------
    -- dev for nvim                                --
    -------------------------------------------------
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    { "Bilal2453/luvit-meta", lazy = true },
    -------------------------------------------------
    -- for language                                --
    -------------------------------------------------
    {
        "mrcjkb/rustaceanvim",
        version = "^4",
        lazy = false,
        config = function()
            require("config/rustaceanvim")
        end,
    },
    {
        "MeanderingProgrammer/markdown.nvim",
        main = "render-markdown",
        opts = {},
        name = "render-markdown",
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    },
})
