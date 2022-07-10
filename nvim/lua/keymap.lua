local s = vim.keymap.set

-- jj to ESC
s("i", "jj", "<ESC>", { noremap = true, silent = true })

-- nvim-tree
s("n", "<space>e", require("nvim-tree").toggle, { noremap = true, silent = true })

-- telescope
s("n", "<space>ff", require("telescope.builtin").find_files, { noremap = true })
s("n", "<space>fg", require("telescope.builtin").live_grep, { noremap = true })
s("n", "<space>fb", require("telescope.builtin").buffers, { noremap = true })
s("n", "<space>fh", require("telescope.builtin").help_tags, { noremap = true })
