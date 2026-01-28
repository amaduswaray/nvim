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
-- vim.cmd("colorscheme catppuccin-mocha")

require('mini.pick').setup()
require('mini.pairs').setup()
require('oil').setup({
	dependencies = {
		"refractalize/oil-git-status.nvim",
	},
	---@type oil.SetupOpts
	win_options = {
		signcolumn = "yes:2",
	},
	view_options = {
		show_hidden = true,
	},
})

require("oil-git-status").setup({
  show_ignored = false,
})
require("stay-centered").setup()
require("colorizer").setup({
  user_default_options = {
    tailwind = true,
  },
})

-- vim.keymap.set('n', '<leader>ff', ":Pick files<CR>", { desc = "Find Files" })
-- vim.keymap.set('n', '<leader>fb', ":Pick buffers<CR>", { desc = "Find Buffers" })
vim.keymap.set('n', '<leader>fh', ":Pick help<CR>",{ desc = "Find Help" })
vim.keymap.set('n', '<leader>e', ":Oil<CR>",{ desc = "Explore" })

vim.lsp.enable({"lua_ls"})
