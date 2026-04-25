require("vim-options")
vim.cmd(":hi statusline guibg=NONE")

vim.pack.add({
	"https://github.com/rose-pine/neovim",
	"https://github.com/NvChad/nvim-colorizer.lua",
	"https://github.com/echasnovski/mini.pairs",
	"https://github.com/echasnovski/mini.pick",
	"https://github.com/L3MON4D3/LuaSnip",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/folke/snacks.nvim",
	"https://github.com/refractalize/oil-git-status.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/saghen/blink.cmp",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/b0o/incline.nvim",
	"https://github.com/williamboman/mason.nvim",
	"https://github.com/williamboman/mason-lspconfig.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/arnamak/stay-centered.nvim",
	"https://github.com/kdheepak/lazygit.nvim",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/windwp/nvim-ts-autotag",
	"https://github.com/folke/noice.nvim",
	"https://github.com/numToStr/Comment.nvim",
	"https://github.com/folke/which-key.nvim",
	"https://github.com/lukas-reineke/indent-blankline.nvim",
	"https://github.com/echasnovski/mini.indentscope",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/OXY2DEV/markview.nvim",
	"https://github.com/stevearc/dressing.nvim",
	"https://github.com/epwalsh/obsidian.nvim",
})

-- PLUGIN SETUPS
require("plugins")

-- NO CONFIG SETUPS
require("mini.pick").setup()
require("mini.pairs").setup()
require("stay-centered").setup()
require("nvim-ts-autotag").setup()
require("dressing").setup()
require("which-key").setup({
	preset = "helix",
})
require("colorizer").setup({
	user_default_options = {
		tailwind = true,
	},
})

-- --- PLUGIN KEYBINDS

-- Help Picker
vim.keymap.set("n", "<leader>fh", "<CMD>Pick help<CR>", { desc = "Find Help" })

-- Open Oil
vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Explore" })

-- Activating lazygit
vim.keymap.set("n", "<leader>gg", "<CMD>LazyGit<CR>")

vim.cmd.colorscheme("rose-pine")
