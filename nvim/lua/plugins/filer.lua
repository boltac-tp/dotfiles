-- return {
-- 	-- https://github.com/nvim-tree/nvim-tree.lua
-- 	"kyazdani42/nvim-tree.lua",
-- 	dependencies = { "kyazdani42/nvim-web-devicons" },
-- 	keys = {
-- 		{
-- 			"<leader>e",
-- 			"<cmd>NvimTreeToggle<CR>",
-- 			noremap = true,
-- 			silent = true,
-- 			desc = "NvimTreeToggle",
-- 		},
-- 	},
-- 	opts = {},
-- }
return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	dependencies = { "kyazdani42/nvim-web-devicons" },
	lazy = false,
	opts = {},
}
