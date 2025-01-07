require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
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
		end, { desc = "Gitsigns next hunk" })

		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end, { desc = "Gitsigns prev hunk" })

		-- Actions
		map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Gitsigns stage hunk" })
		map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Gitsigns reset hunk" })
		map("v", "<leader>hS", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "Gitsigns stage hunk" })
		map("v", "<leader>hR", function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "Gitsigns reset hunk" })
		map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Gitsigns stage buffer" })
		map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Gitsigns undo stage hunk" })
		map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Gitsigns reset buffer" })
		map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Gitsigns preview hunk" })
		map("n", "<leader>hb", function()
			gitsigns.blame_line({ full = true })
		end, { desc = "Gitsigns blame line" })
		map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Gitsigns toggle current line blame" })
		map("n", "<leader>hd", gitsigns.diffthis, { desc = "Gitsigns diffthis" })
		map("n", "<leader>hD", function()
			gitsigns.diffthis("~")
		end, { desc = "Gitsigns diffthis" })
		map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "Gitsigns toggle deleted" })

		-- Text object
		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Gitsigns select hunk" })
	end,
})
