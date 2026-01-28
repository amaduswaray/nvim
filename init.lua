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
	-- { import = "plugins.LSP" },
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

vim.keymap.set("n", "<leader>fh", ":Pick help<CR>", { desc = "Find Help" })
vim.keymap.set("n", "<leader>e", ":Oil<CR>", { desc = "Explore" })

-- Activating lazygit
vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>")

-- LSP Stuff

local lsp_opts = { noremap = true, silent = true }

lsp_opts.desc = "Go to declaration"
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, lsp_opts)

vim.keymap.set("n", "gd", function()
	Snacks.picker.lsp_definitions()
end, vim.tbl_extend("force", lsp_opts, { desc = "Goto Definition" }))

vim.keymap.set("n", "gD", function()
	Snacks.picker.lsp_declarations()
end, vim.tbl_extend("force", lsp_opts, { desc = "Goto Declaration" }))

vim.keymap.set("n", "gI", function()
	Snacks.picker.lsp_implementations()
end, vim.tbl_extend("force", lsp_opts, { desc = "Goto Implementation" }))

vim.keymap.set("n", "gR", function()
	Snacks.picker.lsp_references()
end, vim.tbl_extend("force", lsp_opts, { desc = "References", nowait = true }))

lsp_opts.desc = "See available code actions"
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, lsp_opts)

lsp_opts.desc = "Smart rename"
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, lsp_opts)

lsp_opts.desc = "Show line diagnostics"
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, lsp_opts)

lsp_opts.desc = "Go to previous diagnostic"
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, lsp_opts) -- Depricated, .jump() is the new func

lsp_opts.desc = "Go to next diagnostic"
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, lsp_opts)

lsp_opts.desc = "Show documentation for what is under cursor"
vim.keymap.set("n", "K", vim.lsp.buf.hover, lsp_opts)

lsp_opts.desc = "Restart LSP"
vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", lsp_opts)
