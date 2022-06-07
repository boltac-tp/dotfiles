-- jj to ESC
vim.keymap.set("i", "jj", "<ESC>", { noremap = true, silent = true })

-- nvim-tree
vim.keymap.set("n", "<space>e", require 'nvim-tree'.toggle, { noremap = true, silent = true })

-- telescope
vim.keymap.set("n", "<space>ff", require('telescope.builtin').find_files, { noremap = true })
vim.keymap.set("n", "<space>fg", require('telescope.builtin').live_grep, {noremap = true})
vim.keymap.set("n", "<space>fb", require('telescope.builtin').buffers,{noremap = true})
vim.keymap.set("n", "<space>fh", require('telescope.builtin').help_tags, {noremap = true})
