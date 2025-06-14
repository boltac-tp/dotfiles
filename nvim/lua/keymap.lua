local s = vim.keymap.set
local opts = { noremap = true, silent = true }
-- leader
vim.g.mapleader = " "
vim.g.maplocalloader = " "

-- cursor move
s("n", "gh", "^", opts)
s("n", "gl", "$", opts)
s("n", "gj", "j", opts)
s("n", "gk", "k", opts)
s("n", "j", "gj", opts)
s("n", "k", "gk", opts)
s("n", "ge", "G", opts)

--  See `:help wincmd` for a list of all window commands
s("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
s("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
s("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
s("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- ctrl-jj to ESC
s("i", "<C-j><C-j>", "<ESC>", { noremap = true, silent = true, desc = "ESC" })

-- put <Esc> to nohlsearch
s("n", "<Esc><Esc>", "<cmd>nohlsearch<CR><Esc>", { noremap = true, silent = true })

-- caps
s("i", "<C-l>", function()
	local line = vim.fn.getline(".")
	local col = vim.fn.getpos(".")[3]
	local substring = line:sub(1, col - 1)
	local result = vim.fn.matchstr(substring, [[\v<(\k(<)@!)*$]])
	return "<C-w>" .. result:upper()
end, { expr = true, desc = "caps" })

-- open oil
s("n", "<leader>e", function()
	require("oil").open()
end, { desc = "Oil current buffer's directory" })

-- dial.nvim
s("n", "+", require("dial.map").inc_normal(), opts)
s("n", "_", require("dial.map").dec_normal(), opts)
s("v", "+", require("dial.map").inc_visual(), opts)
s("v", "_", require("dial.map").dec_visual(), opts)
s("v", "g+", require("dial.map").inc_gvisual(), opts)
s("v", "g_", require("dial.map").dec_gvisual(), opts)
s("n", "~", require("dial.map").inc_normal("case"), opts)
s("v", "~", require("dial.map").inc_visual("case"), opts)

-- telescope
local builtin = require("telescope.builtin")
s("n", "<leader>sh", builtin.help_tags, { noremap = true, desc = "Telescope: search help" })
s("n", "<leader>sk", builtin.keymaps, { noremap = true, desc = "Telescope: search keymaps" })
s("n", "<leader>sf", builtin.find_files, { noremap = true, desc = "Telescope: search files" })
s("n", "<leader>ss", builtin.builtin, { noremap = true, desc = "Telescope: search select telescope" })
s("n", "<leader>sw", builtin.grep_string, { noremap = true, desc = "Telescope: search current word" })
s("n", "<leader>sg", builtin.live_grep, { noremap = true, desc = "Telescope: live grep" })
s("n", "<leader>sd", builtin.diagnostics, { noremap = true, desc = "Telescope: search diagnostics" })
s("n", "<leader>sr", builtin.resume, { noremap = true, desc = "Telescope: search resume" })
s("n", "<leader>s.", builtin.oldfiles, { noremap = true, desc = "Telescope: search oldfiles" })
s("n", "<leader><leader>", builtin.buffers, { noremap = true, desc = "Telescope: buffer list" })

s("n", "<leader>/", function()
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { noremap = true, desc = "Telescope: fuzzy search in cullent buffer" })

s("n", "<leader>s/", function()
	builtin.live_grep({
		grep_open_files = true,
		prompt_title = "Live Grpe in Open Files",
	})
end, { noremap = true, desc = "Telescope: grep in open files" })

s("n", "<leader>sn", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Telescope: Search Neovim files" })

s("n", "<leader>fq", builtin.quickfix, { noremap = true, desc = "Telescope: quick fix" })
s("n", "<leader>fc", builtin.commands, { noremap = true, desc = "Telescope: command pallete" })
s(
	"n",
	"<leader>fs",
	require("telescope").extensions.luasnip.luasnip,
	{ noremap = true, desc = "Telescope: luasnip snipets" }
)

-- hover.nvim
s("n", "K", require("hover").hover, { desc = "hover.nvim" })
s("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
s("n", "<C-p>", function()
	require("hover").hover_switch("previous")
end, { desc = "hover.nvim: (previous source)" })
s("n", "<C-n>", function()
	require("hover").hover_switch("next")
end, { desc = "hover.nvim: (next source)" })

-- Mouse support
s("n", "<MouseMove>", require("hover").hover_mouse, { desc = "hover.nvim: (mouse)" })
vim.o.mousemoveevent = true

-- lsp Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
--s("n", "<leader>dd", vim.diagnostic.open_float, { silent = true, desc = "diagnostic open float" })

s("n", "[d", function()
	vim.diagnostic.jump({ count = 1, float = false })
end, { silent = true, desc = "LSP: diagnostic jump to next" })

s("n", "]d", function()
	vim.diagnostic.jump({ count = -1, float = false })
end, { silent = true, desc = "LSP: diagnostic jump to prev" })

s("n", "<leader>q", vim.diagnostic.setloclist, { desc = "LSP: Open diagnostic quickfix list" })

--buffer line
s("n", "]b", "<Cmd>BufferLineCycleNext<CR>", { silent = true, desc = "BufferLine: cycle next" })
s("n", "[b", "<Cmd>BufferLineCyclePrev<CR>", { silent = true, desc = "BufferLine: cycle prev" })

-- LLM cody
s("n", "<leader>9", ":<C-u>CodyToggle<CR>", { silent = true, desc = "Cody: toggle" })

s(
	{ "n", "v" },
	"<C-a>",
	"<cmd>CodeCompanionActions<cr>",
	{ noremap = true, silent = true, desc = "CodeCompation: Actions" }
)
s(
	{ "n", "v" },
	"<Leader>a",
	"<cmd>CodeCompanionChat Toggle<cr>",
	{ noremap = true, silent = true, desc = "CodeCompanion: Chat Toggle" }
)
s("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true, desc = "CodeCompanion: Chat Add" })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])
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
