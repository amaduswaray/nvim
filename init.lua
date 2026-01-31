require("vim-options")

-- Package manager whenever 12 comes out
-- vim.pack.add({
--  {src = "catppuccin/nvim"},
--})
-- THEME: Rose Pine

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
	{ import = "LSP" },
	{ import = "plugins" },
})

require("mini.pick").setup()
require("mini.pairs").setup()
require("oil").setup({
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

vim.keymap.set("n", "<leader>fh", "<CMD>Pick help<CR>", { desc = "Find Help" })
vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Explore" })

-- Activating lazygit
vim.keymap.set("n", "<leader>gg", "<CMD>LazyGit<CR>")

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client then
			client.server_capabilities.semanticTokensProvider = nil
		end
	end,
})
