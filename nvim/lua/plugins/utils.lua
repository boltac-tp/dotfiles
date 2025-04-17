return { -- auto brackets/tag
	{
		"windwp/nvim-autopairs",
		event = { "InsertEnter" },
		opts = { enable_check_bracket_line = false },
	},
	{
		"windwp/nvim-ts-autotag",
		event = { "InsertEnter" },
		opts = {},
	},

	-- nvim-surround
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup()
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("colorizer").setup({ "*" })
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
}
