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

-- vim.keymap.set('n', '<leader>ff', ":Pick files<CR>", { desc = "Find Files" })
-- vim.keymap.set('n', '<leader>fb', ":Pick buffers<CR>", { desc = "Find Buffers" })
vim.keymap.set("n", "<leader>fh", ":Pick help<CR>", { desc = "Find Help" })
vim.keymap.set("n", "<leader>e", ":Oil<CR>", { desc = "Explore" })

-- Activating lazygit
vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>")

-- LSP Stuff

local lsp_opts = { noremap = true, silent = true }
vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", lsp_opts)

lsp_opts.desc = "Go to declaration"
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, lsp_opts)

-- opts.desc = "Show LSP definitions"
-- vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", lsp_opts)
--
-- opts.desc = "Show LSP implementations"
-- vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", lsp_opts)
--
-- opts.desc = "Show LSP type definitions"
-- vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", lsp_opts)
--
lsp_opts.desc = "See available code actions"
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, lsp_opts)

lsp_opts.desc = "Smart rename"
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, lsp_opts)

-- opts.desc = "Show buffer diagnostics"
-- vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", lsp_opts)

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
