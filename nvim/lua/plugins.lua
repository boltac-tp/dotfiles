vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
    use { 'wbthomason/packer.nvim', opt = true }

    -- hops.nvim
    use { 'phaazon/hop.nvim',
        config = function()
            require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran', jump_on_sole_occurrence = false }
        end }

    -- early return for vscode-neovim --
    if vim.g.vscode then return nil end
    ------------------------------------

    -- auto brackets/tag
    use {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup()
        end
    }
    use {
        'windwp/nvim-ts-autotag',
        config = function()
            require('nvim-ts-autotag').setup()
        end
    }

    -- gitsigns
    use { 'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    }

    -- indent
    use 'lukas-reineke/indent-blankline.nvim'

    -- colorizer
    use {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup({
                '*';
            })
        end
    }

    -- color scheme
    use 'EdenEast/nightfox.nvim'
    -- status line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    -- filer
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function()
            require 'nvim-tree'.setup {}
        end
    }

    -- lsp & completion
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'

    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/cmp-nvim-lsp-document-symbol'
    use 'ray-x/cmp-treesitter'

    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/cmp-vsnip'

    use {
        'jose-elias-alvarez/null-ls.nvim',
        requires = "nvim-lua/plenary.nvim"
    }
    use {
        'simrat39/rust-tools.nvim',
        requires = 'mfussenegger/nvim-dap',
        config = function()
            require('rust-tools').setup({})
        end,
    }

    use {
        'j-hui/fidget.nvim',
        config = function()
            require 'fidget'.setup()
        end
    }
    --
    -- treesitter
    use 'nvim-treesitter/nvim-treesitter'
    use {
        'yioneko/nvim-yati',
        requires = 'nvim-treesitter/nvim-treesitter'
    }

    -- fuzzy finder
    use {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)

vim.cmd [[autocmd BufWritePost plugins.lua PackerCompile]]
