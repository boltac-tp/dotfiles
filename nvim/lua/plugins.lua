-- packer install
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.api.nvim_command("packadd packer.nvim")
end

local packer = require("packer")

packer.startup(function(use)
	use("wbthomason/packer.nvim")

	use({ "vim-jp/vimdoc-ja" })

	-------------------------------------------------
	-- dependency                                  --
	-------------------------------------------------

	-------------------------------------------------
	-- code                                        --
	-------------------------------------------------

	-- treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
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
		"williamboman/nvim-lsp-installer",
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
	--	use({
	--		"windwp/nvim-ts-autotag",
	--		config = function()
	--			require("nvim-ts-autotag").setup()
	--		end,
	--	})

	-------------------------------------------------
	-- utility                                     --
	-------------------------------------------------

	-- fuzzy finder
	use({
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		requires = {
			{ "nvim-lua/plenary.nvim" },
		},
	})

	-- filer
	use({
		"kyazdani42/nvim-tree.lua",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({})
		end,
	})

	-------------------------------------------------
	-- visual                                      --
	-------------------------------------------------

	-- gitsigns
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		event = "BufRead",
		cmd = "GitSigns",
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
	--	use({
	--		"simrat39/rust-tools.nvim",
	--		requires = "mfussenegger/nvim-dap",
	--		config = function()
	--			require("rust-tools").setup({})
	--		end,
	--	})
end)

vim.cmd("colorscheme nordfox")

vim.api.nvim_create_augroup("PackerCompile", {})
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = "PackerCompile",
	pattern = "plugins.lua",
	command = "source <afile> | PackerCompile",
	once = false,
})
