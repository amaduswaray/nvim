require("vim-options")

-- Package manager whenever 12 comes out
-- vim.pack.add({
--  {src = "catppuccin/nvim"},
--})
-- THEME: Aura dracula spirit
--vim.cmd("colorscheme catppuccin-mocha")

vim.cmd(":hi statusline guibg=NONE")



-- TMP Lazyvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
	{ import = "plugins" },
})

vim.cmd("colorscheme catppuccin-mocha")

vim.lsp.enable({"lua_ls"})
