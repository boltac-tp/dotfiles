return {
	-- https://github.com/shellRaining/hlchunk.nvim
	"shellRaining/hlchunk.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		chunk = {
			enable = true,
			duration = 100,
			delay = 100,
		},
		indent = {
			enable = true,
		},
	},
}
