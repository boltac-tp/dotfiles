-- leader
vim.g.mapleader = " "

local opt = vim.opt

opt.title = true
opt.number = true
opt.backup = false
opt.swapfile = false
opt.autoread = true
opt.hidden = true
opt.updatetime = 300
opt.smartindent = true
opt.breakindent = true
opt.visualbell = true
opt.showmatch = true
opt.cmdheight = 2
opt.scrolloff = 10

opt.list = true
opt.listchars:append("tab:▏⋅")
opt.listchars:append("eol:↴")
opt.listchars:append("space:⋅")
opt.shiftwidth = 4
opt.expandtab = true
opt.tabstop = 4

opt.inccommand = "nosplit"
opt.ignorecase = true
opt.smartcase = true
opt.wrapscan = true
opt.termguicolors = true

opt.spell = true
opt.spelllang = { "en_us" }

--opt.whichwrap = "b", "s", "h", "l", "<", ">", "[", "]"
opt.backspace = { "start", "eol", "indent" }

opt.helplang = { "ja", "en" }

opt.clipboard:append({ unnamedplus = true })
