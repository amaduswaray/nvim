
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
