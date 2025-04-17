return {
	"lewis6991/gitsigns.nvim",
	-- https://github.com/lewis6991/gitsigns.nvim
	dependencies = { "nvim-lua/plenary.nvim" },
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end, { desc = "gitsigns: next hunk" })

				map("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end, { desc = "gitsigns: prev hunk" })

				-- Actions
				map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "gitsigns: stage hunk" })
				map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "gitsings: reset hunk" })

				map("v", "<leader>hs", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "gitsigns: stage hunk" })

				map("v", "<leader>hr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "gitsigns: reset hunk" })

				map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "gitsigns: stage buffer" })
				map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "gitsigns: reset buffer" })
				map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "gitsigns: preview hunk" })
				map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "gitsigns: preview hunk inline" })

				map("n", "<leader>hb", function()
					gitsigns.blame_line({ full = true })
				end, { desc = "gitsigns: blame line" })

				map("n", "<leader>hd", gitsigns.diffthis, { desc = "gitsigns: diffthis" })

				map("n", "<leader>hD", function()
					gitsigns.diffthis("~")
				end, { desc = "gitsigns: diffthis" })

				map("n", "<leader>hQ", function()
					gitsigns.setqflist("all")
				end, { desc = "gitsigns: setaflist all" })
				map("n", "<leader>hq", gitsigns.setqflist, { desc = "gitsigns: setaflist" })

				-- Toggles
				map(
					"n",
					"<leader>tb",
					gitsigns.toggle_current_line_blame,
					{ desc = "gitsigns: toggle current line blame" }
				)
				map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "gitsigns: toggle deleted" })
				map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "gitsigns: toggle word diff" })

				-- Text object
				map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "gitsigns: select hunk" })
			end,
		})
	end,
}
