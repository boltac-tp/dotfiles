-- packer install
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.api.nvim_command("packadd packer.nvim")
end

local packer = require("packer")

packer.startup(function(use)
	use("wbthomason/packer.nvim")

	-------------------------------------------------
	-- code                                        --
	-------------------------------------------------

	-- lsp & completion
	use("neovim/nvim-lspconfig")
	use("williamboman/nvim-lsp-installer")

	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-nvim-lsp-signature-help")
	use("hrsh7th/cmp-nvim-lsp-document-symbol")
	use("ray-x/cmp-treesitter")

	use("hrsh7th/vim-vsnip")
	use("hrsh7th/cmp-vsnip")

	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = "nvim-lua/plenary.nvim",
	})

	use({
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup()
		end,
	})
	--
	-- treesitter
	use("nvim-treesitter/nvim-treesitter")
	use({
		"yioneko/nvim-yati",
		requires = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = "all",
				highlight = {
					enable = true,
					additional_vim_regex_hilighting = false,
				},
				yati = { enable = true },
			})
		end,
	})

	-------------------------------------------------
	-- actions                                     --
	-------------------------------------------------

	-- lightspeed
	use("ggandor/lightspeed.nvim")

	-- auto brackets/tag
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	})
	use({
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	})

	-------------------------------------------------
	-- utility                                     --
	-------------------------------------------------

	-- filer
	use({
		"kyazdani42/nvim-tree.lua",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({})
		end,
	})

	-- fuzzy finder
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-------------------------------------------------
	-- visual                                      --
	-------------------------------------------------

	-- gitsigns
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	})

	-- indent
	use("lukas-reineke/indent-blankline.nvim")

	-- colorizer
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				"*",
			})
		end,
	})

	-- color scheme
	use({
		"EdenEast/nightfox.nvim",
		config = function()
			require("nightfox").setup({
				paletts = { nordfox = { red = "#ff0000" } },
			})
		end,
	})

	-- status line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("lualine").setup({
				options = {
					component_separators = { left = "|", right = "|" },
					section_separators = { left = "", right = "" },
				},
			})
		end,
	})
	-------------------------------------------------
	-- lunguages                                   --
	-------------------------------------------------
	use({
		"simrat39/rust-tools.nvim",
		requires = "mfussenegger/nvim-dap",
		config = function()
			require("rust-tools").setup({})
		end,
	})
end)

vim.cmd("colorscheme nordfox")

vim.api.nvim_create_augroup("PackerCompile", {})
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = "PackerCompile",
	pattern = "plugins.lua",
	command = "source <afile> | PackerCompile",
	once = false,
})
