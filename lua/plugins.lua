return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		opts = {
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
		},
		config = function(_, opts)
			require("rose-pine").setup(opts)
			vim.cmd("colorscheme rose-pine")
		end,
	},
	"NvChad/nvim-colorizer.lua",
	"stevearc/oil.nvim",
	"refractalize/oil-git-status.nvim",
	"nvim-tree/nvim-web-devicons",
	{ "nvim-mini/mini.pick", version = false },
	{
		"folke/snacks.nvim",
		---@type snacks.Config
		opts = {
			picker = {
				enabled = true,
			},
		},
		keys = {
			{
				"<leader>ff",
				function()
					Snacks.picker.files()
				end,
				desc = "Find Files",
			},
			{
				"<leader>fb",
				function()
					Snacks.picker.buffers({
						layout = "dropdown",
					})
				end,
				desc = "Find Buffers",
			},
			{
				"<leader>fg",
				function()
					Snacks.picker.grep({
						layout = "ivy",
					})
				end,
				desc = "Find Grep",
			},
			{
				"<leader>fr",
				function()
					Snacks.picker.recent()
				end,
				desc = " Find Recent",
			},
			{
				"<leader>gs",
				function()
					Snacks.picker.git_status({
						layout = "telescope",
					})
				end,
				desc = "Git Status",
			},
			{
				"<leader>gl",
				function()
					Snacks.picker.git_log()
				end,
				desc = "Git Log",
			},
			{
				"<leader>fd",
				function()
					Snacks.picker.diagnostics({
						layout = "telescope",
					})
				end,
				desc = "Diagnostics",
			},
			{
				"<leader>fD",
				function()
					Snacks.picker.diagnostics_buffer({
						layout = "telescope",
					})
				end,
				desc = "Buffer Diagnostics",
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			on_attach = function(buffer)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
				end
			end,
		},
	},
	"neovim/nvim-lspconfig",
	"arnamak/stay-centered.nvim",
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "helix",
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		--event = "LazyFile",
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = { enabled = false },
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"NvimTree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
			},
		},
		main = "ibl",
	},
	{
		"echasnovski/mini.indentscope",
		version = false,
		opts = {
			symbol = "│",
			options = { try_as_border = true },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"NvimTree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},
	{
		{
			"stevearc/conform.nvim",
			opts = {
				format_on_save = {
					timeout_ms = 8000,
					lsp_format = "fallback",
				},
				formatters_by_ft = {
					lua = { "stylua" },
					javascript = { "prettierd" },
					javascriptreact = { "prettierd" },
					typescript = { "prettierd" },
					typescriptreact = { "prettierd" },
					json = { "prettierd" },
				},
			},
		},
		{
			"windwp/nvim-ts-autotag",
			config = function()
				require("nvim-ts-autotag").setup()
			end,
		},
	},
	"rafamadriz/friendly-snippets",
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.*",
		build = "cargo build --release",

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = { preset = "default", ["<CR>"] = { "accept", "fallback" } },

			appearance = {
				nerd_font_variant = "mono",
			},
			completion = { documentation = { auto_show = false } },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			fuzzy = { implementation = "lua" },
		},
		opts_extend = { "sources.default" },
	},
	-- Name in the top right
	{
		"b0o/incline.nvim",
		event = "VeryLazy",
		opts = {
			hide = { cursorline = true },
			ignore = {
				buftypes = function(_, buftype)
					return buftype ~= "" and buftype ~= "terminal"
				end,
			},
			window = {
				padding = 0,
				margin = { horizontal = 0 },
			},
			render = function(props)
				-- Typical rendering

				local devicons = require("nvim-web-devicons")

				-- Filename
				local buf_path = vim.api.nvim_buf_get_name(props.buf)
				local dirname = vim.fn.fnamemodify(buf_path, ":~:.:h")
				local dirname_component = { dirname, group = "Comment" }

				local filename = vim.fn.fnamemodify(buf_path, ":t")
				if filename == "" then
					filename = "[No Name]"
				end
				local diagnostic_level = nil
				for _, diagnostic in ipairs(vim.diagnostic.get(props.buf)) do
					diagnostic_level = math.min(diagnostic_level or 999, diagnostic.severity)
				end
				local filename_hl = diagnostic_level == vim.diagnostic.severity.HINT and "DiagnosticHint"
					or diagnostic_level == vim.diagnostic.severity.INFO and "DiagnosticInfo"
					or diagnostic_level == vim.diagnostic.severity.WARN and "DiagnosticWarn"
					or diagnostic_level == vim.diagnostic.severity.ERROR and "DiagnosticError"
					or "Normal"
				local filename_component = { filename, group = filename_hl }

				-- Modified icon
				local modified = vim.bo[props.buf].modified
				local modified_component = modified and { " ● ", group = "BufferCurrentMod" } or ""

				local ft_icon, ft_color = devicons.get_icon_color(filename)
				local icon_component = ft_icon and { " ", ft_icon, " ", guifg = ft_color } or ""

				return {
					modified_component,
					icon_component,
					" ",
					filename_component,
					" ",
					dirname_component,
					" ",
				}
			end,
		},
	},
	{
		"OXY2DEV/markview.nvim",
		lazy = false,
	},
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	-- LSP stuff
	{ "nvim-lua/plenary.nvim", lazy = true },
}
