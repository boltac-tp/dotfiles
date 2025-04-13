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
	-- dependencies                                --
	-------------------------------------------------
	{ "kkharji/sqlite.lua" },
	{ "stevearc/dressing.nvim" },

	-------------------------------------------------
	-- color scheme                                --
	-------------------------------------------------
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme tokyonight-night]])
		end,
	},
	-------------------------------------------------
	-- init                                        --
	-------------------------------------------------
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
		"neovim/nvim-lspconfig",
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
	-- schema
	{
		"b0o/schemastore.nvim",
	},
	-- formatting
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>fm",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		config = function()
			require("config/conform")
		end,
	},
	-- other
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy", -- Or `LspAttach`
		priority = 1000,
		config = function()
			vim.diagnostic.config({ virtual_text = false })
			require("tiny-inline-diagnostic").setup({
				preset = "simple",
			})
		end,
	},
	{
		"lewis6991/hover.nvim",
		config = function()
			require("config/hover")
		end,
	},
	-------------------------------------------------
	-- LLM                                         --
	-------------------------------------------------
	{
		"sourcegraph/sg.nvim",
		event = "LspAttach",
		config = function()
			require("sg").setup()
		end,
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
	-- snipet                                      --
	-------------------------------------------------
	{
		"L3MON4D3/LuaSnip",
		config = function()
			require("config/luasnip")
		end,
	},
	-------------------------------------------------
	-- fazzy finder                                --
	-------------------------------------------------
	{
		"nvim-telescope/telescope.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
			{ "kyazdani42/nvim-web-devicons" },
			{ "nvim-telescope/telescope-file-browser.nvim" },
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "benfowler/telescope-luasnip.nvim" },
			{ "prochri/telescope-all-recent.nvim" },
		},
		config = function()
			require("config/telescope")
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
		"shellRaining/hlchunk.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("config/hlchunk")
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
		version = "^5",
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
