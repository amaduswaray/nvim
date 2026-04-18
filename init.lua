require("vim-options")
-- Read this docs for new add https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack

vim.pack.add({
	"https://github.com/rose-pine/neovim",
	"https://github.com/NvChad/nvim-colorizer.lua",
  "https://github.com/echasnovski/mini.pairs",
  "https://github.com/echasnovski/mini.pick",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/refractalize/oil-git-status.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
  -- "https://github.com/folke/snacks.nvim",
  -- "https://github.com/lewis6991/gitsigns.nvim"
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/arnamak/stay-centered.nvim",
  "https://github.com/kdheepak/lazygit.nvim"
})

vim.cmd(":hi statusline guibg=NONE")


vim.keymap.set("n", "<leader>fh", "<CMD>Pick help<CR>", { desc = "Find Help" })
vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Explore" })

-- Activating lazygit
vim.keymap.set("n", "<leader>gg", "<CMD>LazyGit<CR>")
-- THEME
require("rose-pine").setup(
{
			disable_background = true,
			styles = {
				bold = false,
				italic = true,
				transparency = true,
			},
			highlight_groups = {
				LspInlayHint = { bg = "base", fg = "muted", italic = true },
				NotificationInfo = { bg = "none", fg = "text" },
				NotificationWarning = { bg = "none", fg = "subtle" },
				NotificationError = { bg = "none", fg = "love" },
			},
		}
)

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
	skip_confirm_for_simple_edits = true,
	view_options = {
		show_hidden = true,
	},
	float = {
		padding = 2,
		max_width = 0.9,
		max_height = 0.9,
		border = "rounded",
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

vim.cmd.colorscheme("rose-pine")
