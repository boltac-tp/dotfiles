local s = vim.keymap.set

-- leader
vim.g.mapleader = " "
vim.g.maplocalloader = "\\"

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

-- caps
s("i", "<C-l>", function()
	local line = vim.fn.getline(".")
	local col = vim.fn.getpos(".")[3]
	local substring = line:sub(1, col - 1)
	local result = vim.fn.matchstr(substring, [[\v<(\k(<)@!)*$]])
	return "<C-w>" .. result:upper()
end, { expr = true })
--
-- telescope
local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
s("n", "<leader>ff", telescope_builtin.find_files, { noremap = true, desc = "telescope find files" })
s("n", "<leader>/", telescope_builtin.live_grep, { noremap = true, desc = "telescope live grep" })
s("n", "<leader>fh", telescope_builtin.help_tags, { noremap = true, desc = "telescope help tags" })
s("n", "<leader>fb", telescope_builtin.buffers, { noremap = true, desc = "telescope buffer list" })
s("n", "<leader>fq", telescope_builtin.quickfix, { noremap = true, desc = "telescope quick fix" })
s("n", "<leader>fd", telescope_builtin.diagnostics, { noremap = true, desc = "telescope diagnostics" })
s("n", "<leader>fk", telescope_builtin.keymaps, { noremap = true, desc = "telescope keymaps" })
s("n", "<leader>fc", telescope_builtin.commands, { noremap = true, desc = "telescope command pallete" })
s(
	"n",
	"<leader>fe",
	telescope.extensions.file_browser.file_browser,
	{ noremap = true, desc = "telescope file browser" }
)
s("n", "<leader>fs", telescope.extensions.luasnip.luasnip, { noremap = true, desc = "telescope luasnip snipets" })

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
s("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { noremap = true, desc = "LSPsaga code actions" })
-- rename
s("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { silent = true, desc = "LSPsaga rename" })
-- Definition preview
s("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true, desc = "LSPsaga peek definision" })
s("n", "gD", "<cmd>Lspsaga goto_definition<CR>", { silent = true, desc = "LSPsaga goto definision" })
-- Definition type preview
s("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>", { silent = true, desc = "LSPsaga peek type definition" })
s("n", "gT", "<cmd>Lspsaga goto_type_definition<CR>", { silent = true, desc = "LSPsaga goto type definition" })
-- Diagnostic jump can use '<c-o>' to jump back
s("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true, desc = "LSPsaga diagnostic jump next" })
s("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true, desc = "LSPsaga diagnostic jump prev" })
s("n", "]e", function()
	require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true, desc = "Lspsaga error jump next" })
s("n", "[e", function()
	require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true, desc = "Lspsaga error jump prev" })

-- Diagnnostic
-- s("n", "<leader>l", "<cmd>Lspsaga show_buf_diagnostics<CR>", { silent = true })
-- Outline
s("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { silent = true, desc = "LSPsaga outline" })
-- Hovor Doc
s("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true, desc = "LSPsaga hover doc" })
-- float terminal
-- s("n", "<A-t>", "<cmd>Lspsaga term_toggle<CR>", { silent = true })

--buffer line
s("n", "]b", "<Cmd>BufferLineCycleNext<CR>", { silent = true, desc = "BufferLine cycle next" })
s("n", "[b", "<Cmd>BufferLineCyclePrev<CR>", { silent = true, desc = "BufferLine cycle prev" })

--dap
s("n", "<leader>dap", ':lua require("dapui").toggle()<CR>', { desc = "DAP" })

s("n", "<F5>", function()
	require("dap").continue()
end, { desc = "DAP continue" })
s("n", "<F10>", function()
	require("dap").step_over()
end, { desc = "DAP step over" })
s("n", "<F11>", function()
	require("dap").step_into()
end, { desc = "DAP step into" })
s("n", "<F12>", function()
	require("dap").step_out()
end, { desc = "DAP step out" })
s("n", "<Leader>m", function()
	require("dap").toggle_breakpoint()
end, { desc = "DAP toggle breakpoint" })
s("n", "<Leader>M", function()
	require("dap").set_breakpoint()
end, { desc = "DAP set breakpoint" })
s("n", "<Leader>lp", function()
	require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, { desc = "DAP log point message" })
s("n", "<Leader>dr", function()
	require("dap").repl.open()
end, { desc = "DAP repl" })
s("n", "<Leader>dl", function()
	require("dap").run_last()
end, { desc = "DAP run last" })
s({ "n", "v" }, "<Leader>dh", function()
	require("dap.ui.widgets").hover()
end, { desc = "DAP hover" })
s({ "n", "v" }, "<Leader>dp", function()
	require("dap.ui.widgets").preview()
end, { desc = "DAP preview" })
s("n", "<Leader>df", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.frames)
end, { desc = "DAP centered float frames" })
s("n", "<Leader>ds", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes)
end, { desc = "DAP centered float scopes" })
