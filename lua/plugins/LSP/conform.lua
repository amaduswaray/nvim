require("conform").setup({
	format_on_save = {
		timeout_ms = 8000,
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "oxfmt" },
		javascriptreact = { "oxfmt" },
		typescript = { "oxfmt" },
		typescriptreact = { "oxfmt" },
		json = { "oxfmt" },
		blade = { "blade-formatter" },
	},
})
