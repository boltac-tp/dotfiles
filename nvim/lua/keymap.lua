local s = vim.keymap.set

-- leader
vim.g.mapleader = " "

-- jj to ESC
s("i", "jj", "<ESC>", { noremap = true, silent = true })

-- put <Esc> to nohlsearch
s("n", "<Esc><Esc>", "<cmd>nohlsearch<CR><Esc>", { noremap = true, silent = true })

-- nvim-tree
s("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { noremap = true, silent = true })

-- telescope
local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
s("n", "<leader>ff", telescope_builtin.find_files, { noremap = true })
s("n", "<leader>fg", telescope_builtin.live_grep, { noremap = true })
s("n", "<leader>fh", telescope_builtin.help_tags, { noremap = true })
s("n", "<leader>fb", telescope.extensions.file_browser.file_browser, { noremap = true })

-- lsp
--s("n", "<space>d", vim.diagnostic.open_float , { noremap = true, silent = true })
--s("n", "[d", vim.diagnostic.goto_prev, { noremap = true, silent = true })
--s("n", "]d", vim.diagnostic.goto_next, { noremap = true, silent = true })
s("n", "<leader>q", vim.diagnostic.setloclist, { noremap = true, silent = true })

-- lspsaga
-- lsp finder
s("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
-- code action
s("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
-- rename
s("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { silent = true })
-- Definition preview
s("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
s("n", "gd", "<cmd>Lspsaga goto_difinition<CR>", { silent = true })
-- Show diagonostics
s("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
s("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })
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
s("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", { silent = true })
-- Hovor Doc
s("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
-- float terminal
-- s("n", "<A-t>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
-- s("t", "<A-t>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })

--buffer line
s("n", "]b", "<Cmd>BufferLineCycleNext<CR>", {})
s("n", "[b", "<Cmd>BufferLineCyclePrev<CR>", {})
