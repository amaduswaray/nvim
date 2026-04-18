require("blink.cmp").setup({
	keymap = {
		preset = "default",
		["<CR>"] = { "accept", "fallback" },
	},

	appearance = {
		nerd_font_variant = "mono",
	},

	completion = {
		documentation = { auto_show = false },
	},

	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},

	fuzzy = {
		implementation = "lua",
	},
})
