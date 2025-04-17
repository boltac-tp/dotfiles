return {
	-- https://github.com/nvim-telescope/telescope.nvim
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
		require("telescope").setup({
			defaults = {
				mappings = {
					n = {
						["q"] = require("telescope.actions").close,
					},
				},
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = { prompt_position = "bottom", preview_width = 0.6 },
					width = 0.90,
					height = 0.90,
					preview_cutoff = 120,
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
				file_browser = {
					hijack_netrw = true,
				},
			},
			resolve = {
				resolve_width = { 0.4 },
			},
		})
		pcall(require("telescope").load_extension, "luasnip")
		pcall(require("telescope").load_extension, "ui-select")
	end,
}
