function _G.get_winbar()
	local buf_path = vim.api.nvim_buf_get_name(0)
	if buf_path == "" or vim.bo.buftype ~= "" then
		return ""
	end

	local devicons = require("nvim-web-devicons")
	local filename = vim.fn.fnamemodify(buf_path, ":t")
	local dirname = vim.fn.fnamemodify(buf_path, ":~:.:h")

	local ft_icon, ft_color = devicons.get_icon_color(filename)
	local icon_component = ""
	if ft_icon then
		vim.api.nvim_set_hl(0, "WinbarFileIcon", { fg = ft_color, bg = "none" })
		icon_component = "%#WinbarFileIcon#" .. ft_icon .. " "
	end

	local diagnostic_level = nil
	local diagnostics = vim.diagnostic.get(0)
	for _, diagnostic in ipairs(diagnostics) do
		diagnostic_level = math.min(diagnostic_level or 999, diagnostic.severity)
	end

	local filename_hl = "Normal"
	if diagnostic_level == vim.diagnostic.severity.HINT then
		filename_hl = "DiagnosticHint"
	elseif diagnostic_level == vim.diagnostic.severity.INFO then
		filename_hl = "DiagnosticInfo"
	elseif diagnostic_level == vim.diagnostic.severity.WARN then
		filename_hl = "DiagnosticWarn"
	elseif diagnostic_level == vim.diagnostic.severity.ERROR then
		filename_hl = "DiagnosticError"
	end

	local modified = vim.bo.modified
	local modified_component = modified and "%#ModifiedColor#● " or ""

	return string.format(
		"%%= %s%s%%#%s#%s %%#Comment#%s %%= ",
		modified_component,
		icon_component,
		filename_hl,
		filename,
		dirname
	)
end

vim.opt.winbar = "%{%v:lua.get_winbar()%}"
