return {
	{
		-- https://github.com/windwp/nvim-autopairs
		"windwp/nvim-autopairs",
		event = { "InsertEnter" },
		opts = { enable_check_bracket_line = false },
	},
	{
		-- https://github.com/windwp/nvim-ts-autotag
		"windwp/nvim-ts-autotag",
		event = { "InsertEnter" },
		opts = {},
	},
	{
		-- https://github.com/kylechui/nvim-surround
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup()
		end,
	},
	{
		-- https://github.com/norcalli/nvim-colorizer.lua
		"norcalli/nvim-colorizer.lua",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("colorizer").setup({ "*" })
		end,
	},
	{
		-- https://github.com/folke/noice.nvim
		"folke/noice.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
		event = "VeryLazy",
		config = function()
			require("noice").setup()
		end,
	},
	{
		-- https://github.com/monaqa/dial.nvim
		"monaqa/dial.nvim",
		event = "VeryLazy",
		config = function()
			local augend = require("dial.augend")
			require("dial.config").augends:register_group({
				-- default augends used when no group name is specified
				default = {
					augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
					augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
					augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
					augend.constant.alias.bool, -- boolean value (true <-> false)
					augend.case.new({
						types = { "camelCase", "snake_case", "PascalCase", "SCREAMING_SNAKE_CASE" },
						cyclic = true,
					}),
				},
				case = {
					augend.case.new({
						types = { "camelCase", "snake_case", "PascalCase", "SCREAMING_SNAKE_CASE" },
						cyclic = true,
					}),
				},
			})
		end,
	},
}
