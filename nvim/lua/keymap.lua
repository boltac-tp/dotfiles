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
s("n", "<leader>dd", vim.diagnostic.open_float, { silent = true, desc = "diagnostic open float" })

s("n", "[d", function()
    vim.diagnostic.jump({ count = 1, float = true })
end, { silent = true, desc = "diagnostic jump to next" })

s("n", "]d", function()
    vim.diagnostic.jump({ count = -1, float = true })
end, { silent = true, desc = "diagnostic jump to prev" })
s("n", "<leader>q", vim.diagnostic.setloclist)

--buffer line
s("n", "]b", "<Cmd>BufferLineCycleNext<CR>", { silent = true, desc = "BufferLine cycle next" })
s("n", "[b", "<Cmd>BufferLineCyclePrev<CR>", { silent = true, desc = "BufferLine cycle prev" })

-- LLM cody
s("n", "<leader>9", ":<C-u>CodyToggle<CR>", { silent = true, desc = "Cody toggle" })

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
