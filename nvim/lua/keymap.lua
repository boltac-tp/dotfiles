local s = vim.keymap.set

-- jj to ESC
s("i", "jj", "<ESC>", { noremap = true, silent = true })

-- put <Esc> to nohlsearch
s("n", "<Esc><Esc>", "<cmd>nohlsearch<CR><Esc>", { noremap = true, silent = true })

-- nvim-tree
s("n", "<space>e", require("nvim-tree").toggle, { noremap = true, silent = true })

-- telescope
s("n", "<space>ff", "<cmd>Telescope find_files<CR>", { noremap = true })
s("n", "<space>fg", "<cmd>Telescope live_grep<CR>", { noremap = true })
--s("n", "<space>fb", "<cmd>Telescope buffers<CR>", { noremap = true })
s("n", "<space>fh", "<cmd>Telescope help_tags<CR>", { noremap = true })
-- telescope file browser
s("n", "<space>fb", "<cmd>Telescope file_browser<CR>", { noremap = true })

-- lspsaga
-- lsp finder
s("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
-- code action
s("n", "<space>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
s("v", "<space>ca", "<cmd><C-U>Lspsaga range_code_action<CR>", { silent = true })
-- rename
s("n", "<space>rn", "<cmd>Lspsaga rename<CR>", { silent = true })
-- Definition preview
s("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
-- Show diagonostics
s("n", "<space>d", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
s("n", "<space>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })
-- Diagnsotic jump can use '<c-o>' to jump back
s("n", "[e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
s("n", "]e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
-- Only jump to error
s("n", "[E", function()
	require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
s("n", "]E", function()
	require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
-- Outline
s("n", "<space>o", "<cmd>LSoutlineToggle<CR>", { silent = true })
-- Hovor Doc
s("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
-- float terminal
s("n", "<A-t>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
s("t", "<A-t>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })

--buffer line
s("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", {})
s("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", {})
