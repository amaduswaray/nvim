local incline = require("incline")

incline.setup({
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
		local devicons = require("nvim-web-devicons")

		-- buffer path
		local buf_path = vim.api.nvim_buf_get_name(props.buf)

		-- directory
		local dirname = vim.fn.fnamemodify(buf_path, ":~:.:h")
		local dirname_component = { dirname, group = "Comment" }

		-- filename
		local filename = vim.fn.fnamemodify(buf_path, ":t")
		if filename == "" then
			filename = "[No Name]"
		end

		-- diagnostics coloring
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

		-- modified flag
		local modified = vim.bo[props.buf].modified
		local modified_component = modified and { " ● ", guifg = "#9ccfd8", guibg = "NONE" } or ""

		-- icon
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
})
