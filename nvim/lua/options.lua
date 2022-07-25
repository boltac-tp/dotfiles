local opt = vim.opt

opt.title = true
opt.number = true
opt.backup = false
opt.swapfile = false
opt.autoread = true
opt.hidden = true
opt.updatetime = 300
opt.smartindent = true
opt.visualbell = true
opt.showmatch = true
opt.cmdheight = 2

opt.list = true
opt.listchars = { tab = ">-", trail = "*", nbsp = "+" }
opt.shiftwidth = 4
opt.expandtab = true
opt.tabstop = 4

opt.ignorecase = true
opt.smartcase = true
opt.wrapscan = true

opt.whichwrap =  "b", "s", "h", "l", "<", ">", "[", "]" 
opt.backspace = { "start", "eol", "indent" }

opt.helplang = { "ja", "en" }

opt.clipboard:append({ unnamedplus = true })
