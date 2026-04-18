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
