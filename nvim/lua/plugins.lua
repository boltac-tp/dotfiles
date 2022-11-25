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
	-------------------------------------------------
	-- init                                        --
	-------------------------------------------------

	use({ "wbthomason/packer.nvim", opt = true })

	use({
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	})

	use("vim-jp/vimdoc-ja")

	-------------------------------------------------
	-- dependency                                  --
	-------------------------------------------------

	use("nvim-lua/plenary.nvim")
	use("kyazdani42/nvim-web-devicons")

	-------------------------------------------------
	-- completion                                  --
	-------------------------------------------------

	use({ "windwp/nvim-autopairs" })

	use({
		"hrsh7th/nvim-cmp",
		requires = {
			{ "L3MON4D3/LuaSnip" },
			{ "windwp/nvim-autopairs" },
		},
		config = function()
			require("plugin.nvim-cmp")
		end,
	})

	use({
		"onsails/lspkind.nvim",
		module = "lspkind",
		config = function()
			require("plugin.lspkind-nvim")
		end,
	})

	use({ "hrsh7th/cmp-nvim-lsp", module = "cmp_nvim_lsp" })
	use({ "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lsp-document-symbol", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-path", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-emoji", after = "nvim-cmp" })
	use({ "f3fora/cmp-spell", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-cmdline", after = "nvim-cmp" })
	use({ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" })
	use({ "ray-x/cmp-treesitter", after = "nvim-cmp" })
	use({ "lukas-reineke/cmp-under-comparator", module = "cmp-under-comparator" })

	-------------------------------------------------
	-- LSP                                         --
	-------------------------------------------------

	use({ "neovim/nvim-lspconfig" })
	use({
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("plugin.mason-lsp")
		end,
	})

	use({
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup()
		end,
	})

	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		config = function()
			local saga = require("lspsaga")
			saga.init_lsp_saga()
		end,
	})

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
		after = "mason.nvim",
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

	-------------------------------------------------
	-- fazzy finder                                --
	-------------------------------------------------

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

	-------------------------------------------------
	-- snipet                                      --
	-------------------------------------------------

	use({
		"L3MON4D3/LuaSnip",
		config = function()
			require("plugin.luasnip")
		end,
	})
	use({
		"benfowler/telescope-luasnip.nvim",
		config = function()
			require("telescope").load_extension("luasnip")
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
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({
				show_end_of_line = true,
				space_char_blankline = " ",
			})
		end,
	})

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
				options = {
					dim_inactive = false,
				},
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

	-- notice
	use({ "rcarriga/nvim-notify" })

	if packer_bootstrap then
		require("packer").sync()
	end
	vim.cmd("colorscheme nordfox")
end)
