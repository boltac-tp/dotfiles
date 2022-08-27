local s = vim.keymap.set

-- jj to ESC
s("i", "jj", "<ESC>", { noremap = true, silent = true })

-- put <Esc> to nohlsearch
s("n", "<Esc><Esc>", "<cmd>nohlsearch<CR><Esc>", { noremap = true, silent = true })
--
-- nvim-tree
s("n", "<space>e", require("nvim-tree").toggle, { noremap = true, silent = true })

-- telescope
s("n", "<space>ff", "<cmd>Telescope find_files<CR>", { noremap = true })
s("n", "<space>fg", "<cmd>Telescope live_grep<CR>", { noremap = true })
s("n", "<space>fb", "<cmd>Telescope buffers<CR>", { noremap = true })
s("n", "<space>fh", "<cmd>Telescope help_tags<CR>", { noremap = true })
