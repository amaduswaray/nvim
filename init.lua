require("vim-options")
vim.cmd(":hi statusline guibg=NONE")

vim.pack.add({
	{ src = "https://github.com/rose-pine/neovim" },
	{ src = "https://github.com/NvChad/nvim-colorizer.lua" },
	{ src = "https://github.com/echasnovski/mini.pairs" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/folke/snacks.nvim" },
	{ src = "https://github.com/refractalize/oil-git-status.nvim" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/williamboman/mason.nvim" },
	{ src = "https://github.com/williamboman/mason-lspconfig.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/arnamak/stay-centered.nvim" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/windwp/nvim-ts-autotag" },
	{ src = "https://github.com/folke/noice.nvim" },
	{ src = "https://github.com/numToStr/Comment.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/OXY2DEV/markview.nvim" },
	{ src = "https://github.com/stevearc/dressing.nvim" },
	{ src = "https://github.com/epwalsh/obsidian.nvim" },
	{ src = "https://github.com/nicolasgb/jj.nvim" },
	{ src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
	{
		src = "https://github.com/kylechui/nvim-surround",
		version = vim.version.range("4.x"),
	},
})

-- PLUGIN SETUPS
require("plugins")

-- NO CONFIG SETUPS
require("mini.pick").setup()
require("mini.pairs").setup()
require("stay-centered").setup()
require("nvim-ts-autotag").setup()
require("dressing").setup()
require("jj").setup({})
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

vim.cmd.colorscheme("rose-pine")
