return {
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
				placement = {
					horizontal = "right",
				},
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

				local modified = vim.bo[props.buf].modified
				local modified_component = modified and { " ● ", guifg = "#9ccfd8", guibg = "NONE" } or ""

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
	,
	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},
	{ "nvim-lua/plenary.nvim", lazy = true },
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		keys = {
			{
				"<leader>cd",
				"<cmd>ObsidianToday<cr>",
				desc = "Obsidian Daily Note Today",
			},
			{ "<leader>ct", "<cmd>ObsidianTemplate<cr>", desc = "Obsidian Insert Template" },
		},
		-- ft = "markdown", -- Activate this and remove event if you want the plugin to apply to all md files
		event = {
			"BufReadPre ~/Library/Mobile Documents/iCloud~md~obsidian/Documents/UiO/*.md",
			"BufNewFile ~/Library/Mobile Documents/iCloud~md~obsidian/Documents/UiO/*.md",
		},
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",
		},
		opts = {
			workspaces = {
				{
					name = "UiO",
					path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/UiO",
				},
			},
			daily_notes = {
				folder = "Z - Daily Notes",
				date_format = "%Y-%m-%d",
				template = "Templates/Daily.md",
			},
			templates = {
				folder = "Templates",
				date_format = "%Y-%m-%d",
				time_format = "%H:%M",
			},
			mappings = {
				-- Toogle check-boxes
				["<leader>ch"] = {
					action = function()
						return require("obsidian").util.toggle_checkbox()
					end,
					opts = { buffer = true, desc = "Obsidian Toggle Checkbox" },
				},
			},
			-- Remove the metadata formatting from the plugin
			disable_frontmatter = true,
			---@return table
			note_frontmatter_func = function(note)
				local out = {}
				if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
					for k, v in pairs(note.metadata) do
						out[k] = v
					end
				end

				return out
			end,
		},
	},
}
