local M = {}

function M.setup()
	local obsidian = require("obsidian")

	obsidian.setup({
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
			["<leader>ch"] = {
				action = function()
					return require("obsidian").util.toggle_checkbox()
				end,
				opts = { buffer = true, desc = "Obsidian Toggle Checkbox" },
			},
		},

		disable_frontmatter = true,

		note_frontmatter_func = function(note)
			local out = {}

			if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
				for k, v in pairs(note.metadata) do
					out[k] = v
				end
			end

			return out
		end,
	})

	-- keymaps (replacement for lazy.nvim `keys`)
	vim.keymap.set("n", "<leader>cd", "<cmd>ObsidianToday<cr>", {
		desc = "Obsidian Daily Note Today",
	})

	vim.keymap.set("n", "<leader>ct", "<cmd>ObsidianTemplate<cr>", {
		desc = "Obsidian Insert Template",
	})

	-- optional: if you want lazy-like file triggering
	vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
		pattern = {
			vim.fn.expand("~/Library/Mobile Documents/iCloud~md~obsidian/Documents/UiO/*.md"),
		},
		callback = function()
			-- ensures plugin is initialized when entering vault
			-- (safe if already loaded)
			if not vim.g.obsidian_loaded then
				vim.g.obsidian_loaded = true
				require("obsidian").setup({
					workspaces = {
						{
							name = "UiO",
							path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/UiO",
						},
					},
				})
			end
		end,
	})
end

M.setup()

return M
