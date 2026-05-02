require("rose-pine").setup({
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

		WinBar = { bg = "none", underline = false, sp = "#44415a" }, -- 'sp' is the underline color (using Rose Pine 'highlight_med')
		WinBarNC = { bg = "none", underline = false, sp = "#26233a" }, -- 'sp' for inactive windows (using 'surface')
		ModifiedColor = { fg = "#9ccfd8", bg = "none" },
	},
})
