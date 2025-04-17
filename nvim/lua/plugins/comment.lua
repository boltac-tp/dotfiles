return {
	-- https://github.com/numToStr/Comment.nvim
	"numToStr/Comment.nvim",
	lazy = false,
	config = function()
		require("Comment").setup()
	end,
}
