-- packer install
local ensure_packer = function()
	local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
		vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	use({ "wbthomason/packer.nvim", opt = true })

	use("vim-jp/vimdoc-ja")

	-------------------------------------------------
	-- dependency                                  --
	-------------------------------------------------

	use("nvim-lua/plenary.nvim")

	-------------------------------------------------
	-- code                                        --
	-------------------------------------------------

	-- treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		event = { "BufRead", "InsertEnter" },
		requires = {
			{ "yioneko/nvim-yati", after = "nvim-treesitter" },
		},
		config = function()
			require("plugin.treesitter")
		end,
	})

	-- formatting
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("plugin.null-ls")
		end,
	})

	-- code actions
	use({
		"weilbith/nvim-code-action-menu",
		cmd = "CodeActionMenu",
		config = function()
			vim.g.code_action_menu_show_details = false
		end,
	})

	-- lsp
	use("neovim/nvim-lspconfig")
	use({
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	})

	use({
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("plugin.lsp")
		end,
	})

	use({
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup()
		end,
	})

	use({ "onsails/lspkind.nvim" })

	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		config = function()
			local saga = require("lspsaga")
			saga.init_lsp_saga()
		end,
	})

	-- completion
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
			{ "hrsh7th/cmp-path", after = "nvim-cmp" },
			{ "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp-document-symbol", after = "nvim-cmp" },
			{ "ray-x/cmp-treesitter", after = "nvim-cmp" },
			{ "hrsh7th/vim-vsnip", after = "nvim-cmp" },
			{ "hrsh7th/cmp-vsnip", after = "nvim-cmp" },
		},
		event = { "InsertEnter", "CmdlineEnter" },
		cmd = { "CmpStatus" },
		config = function()
			require("plugin.cmp")
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
		event = { "InsertEnter" },
		config = function()
			require("nvim-autopairs").setup({
				enable_check_bracket_line = false,
			})
		end,
	})

	-- nvim-surround
	use({
		"kylechui/nvim-surround",
		tag = "*",
		config = function()
			require("nvim-surround").setup({})
		end,
	})

	-------------------------------------------------
	-- utility                                     --
	-------------------------------------------------

	-- terminal
	use({
		"akinsho/toggleterm.nvim",
		config = function()
			require("plugin.toggleterm")
		end,
	})
	-- fuzzy finder
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
			{ "kyazdani42/nvim-web-devicons" },
			{ "nvim-telescope/telescope-file-browser.nvim" },
		},
		config = function()
			require("plugin.telescope")
		end,
	})

	-- filer
	use({
		"kyazdani42/nvim-tree.lua",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup()
		end,
	})

	-------------------------------------------------
	-- visual                                      --
	-------------------------------------------------

	-- gitsigns
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		-- event = "BufRead",
		-- cmd = "GitSigns",
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

	-- buffer line
	use({
		"akinsho/bufferline.nvim",
		tag = "v2.*",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					always_show_bufferline = false,
				},
			})
		end,
	})
	if packer_bootstrap then
		require("packer").sync()
	end
	vim.cmd("colorscheme nordfox")
end)
