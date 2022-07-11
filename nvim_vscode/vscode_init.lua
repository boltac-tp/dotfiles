local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.api.nvim_command("packadd packer.nvim")
end

local packer = require("packer")
packer.startup(function(use)
	use("wbthomason/packer.nvim")
end
)

-- keymaps
local s = vim.keymap.set
-- jj to ESC
s("i", "jj", "<ESC>", { noremap = true, silent = true })


vim.api.nvim_create_augroup("PackerCompile", {})
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = "PackerCompile",
	pattern = "plugins.lua",
	command = "source <afile> | PackerCompile",
	once = false,
})
