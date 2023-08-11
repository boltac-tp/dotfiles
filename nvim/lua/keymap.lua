local s = vim.keymap.set

-- leader
vim.g.mapleader = " "

-- jj to ESC
s("i", "jj", "<ESC>", { noremap = true, silent = true })

-- put <Esc> to nohlsearch
s("n", "<Esc><Esc>", "<cmd>nohlsearch<CR><Esc>", { noremap = true, silent = true })

-- telescope
local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
s("n", "<leader>ff", telescope_builtin.find_files, { noremap = true })
s("n", "<leader>fg", telescope_builtin.live_grep, { noremap = true })
s("n", "<leader>fh", telescope_builtin.help_tags, { noremap = true })
s("n", "<leader>fb", telescope.extensions.file_browser.file_browser, { noremap = true })
s("n", "<leader>fs", telescope.extensions.luasnip.luasnip, { noremap = true })

-- lsp Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
--s("n", "<leader>d", vim.diagnostic.open_float)
--s("n", "[d", vim.diagnostic.goto_prev)
--s("n", "]d", vim.diagnostic.goto_next)
s("n", "<leader>q", vim.diagnostic.setloclist)

-- lspsaga
-- lsp finder
s("n", "gh", "<cmd>Lspsaga finder<CR>", { silent = true })
-- code action
s("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
-- rename
s("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { silent = true })
-- Definition preview
s("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
s("n", "gD", "<cmd>Lspsaga goto_definition<CR>", { silent = true })
-- Definition type preview
s("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>", { silent = true })
s("n", "gT", "<cmd>Lspsaga goto_type_definition<CR>", { silent = true })
-- Diagnostic jump can use '<c-o>' to jump back
s("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
s("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
s("n", "]e", function()
    require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
end)
s("n", "[e", function()
    require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
end)

-- Diagnnostic
s("n", "<leader>d", "<cmd>Lspsaga show_buf_diagnostics<CR>", { silent = true })
-- Outline
s("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { silent = true })
-- Hovor Doc
s("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
-- float terminal
-- s("n", "<A-t>", "<cmd>Lspsaga term_toggle<CR>", { silent = true })

--buffer line
s("n", "]b", "<Cmd>BufferLineCycleNext<CR>", {})
s("n", "[b", "<Cmd>BufferLineCyclePrev<CR>", {})
