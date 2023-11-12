local s = vim.keymap.set

-- leader
vim.g.mapleader = " "

-- cursor move
s("n", "gh", "^", { noremap = true, silent = true })
s("n", "gl", "$", { noremap = true, silent = true })
s("n", "gj", "j", { noremap = true, silent = true })
s("n", "gk", "k", { noremap = true, silent = true })
s("n", "j", "gj", { noremap = true, silent = true })
s("n", "k", "gk", { noremap = true, silent = true })
s("n", "ge", "G", { noremap = true, silent = true })

-- ctrl-jj to ESC
s("i", "<C-j><C-j>", "<ESC>", { noremap = true, silent = true })

-- put <Esc> to nohlsearch
s("n", "<Esc><Esc>", "<cmd>nohlsearch<CR><Esc>", { noremap = true, silent = true })

-- telescope
local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
s("n", "<leader>f", telescope_builtin.find_files, { noremap = true, desc = "find files" })
s("n", "<leader>/", telescope_builtin.live_grep, { noremap = true, desc = "live grep" })
s("n", "<leader>h", telescope_builtin.help_tags, { noremap = true, desc = "help tags" })
s("n", "<leader>b", telescope_builtin.buffers, { noremap = true, desc = "buffer list" })
s("n", "<leader>q", telescope_builtin.quickfix, { noremap = true, desc = "quick fix" })
s("n", "<leader>d", telescope_builtin.diagnostics, { noremap = true, desc = "diagnostics" })
s("n", "<leader>k", telescope_builtin.keymaps, { noremap = true, desc = "keymaps" })
s("n", "<leader>c", telescope_builtin.commands, { noremap = true, desc = "command pallete" })
s("n", "<leader>l", telescope.extensions.file_browser.file_browser, { noremap = true, desc = "file browser" })
s("n", "<leader>s", telescope.extensions.luasnip.luasnip, { noremap = true, desc = "luasnip snipets" })

-- lsp Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
--s("n", "<leader>d", vim.diagnostic.open_float)
--s("n", "[d", vim.diagnostic.goto_prev)
--s("n", "]d", vim.diagnostic.goto_next)
--s("n", "<leader>q", vim.diagnostic.setloclist)

-- lspsaga
-- lsp finder
--s("n", "gh", "<cmd>Lspsaga finder<CR>", { silent = true })
-- code action
s("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { noremap = true, desc = "code actions" })
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
-- s("n", "<leader>l", "<cmd>Lspsaga show_buf_diagnostics<CR>", { silent = true })
-- Outline
s("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { silent = true })
-- Hovor Doc
s("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
-- float terminal
-- s("n", "<A-t>", "<cmd>Lspsaga term_toggle<CR>", { silent = true })

--buffer line
s("n", "]b", "<Cmd>BufferLineCycleNext<CR>", {})
s("n", "[b", "<Cmd>BufferLineCyclePrev<CR>", {})

--dap
s("n", "<leader>dap", ':lua require("dapui").toggle()<CR>', {})

s("n", "<F5>", function()
	require("dap").continue()
end)
s("n", "<F10>", function()
	require("dap").step_over()
end)
s("n", "<F11>", function()
	require("dap").step_into()
end)
s("n", "<F12>", function()
	require("dap").step_out()
end)
s("n", "<Leader>m", function()
	require("dap").toggle_breakpoint()
end)
s("n", "<Leader>M", function()
	require("dap").set_breakpoint()
end)
s("n", "<Leader>lp", function()
	require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end)
s("n", "<Leader>dr", function()
	require("dap").repl.open()
end)
s("n", "<Leader>dl", function()
	require("dap").run_last()
end)
s({ "n", "v" }, "<Leader>dh", function()
	require("dap.ui.widgets").hover()
end)
s({ "n", "v" }, "<Leader>dp", function()
	require("dap.ui.widgets").preview()
end)
s("n", "<Leader>df", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.frames)
end)
s("n", "<Leader>ds", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes)
end)
