require("luasnip.loaders.from_vscode").lazy_load()

require("blink.cmp").setup({
	snippets = { preset = "luasnip" },
	keymap = {
		preset = "default",
		["<Tab>"] = { "accept", "fallback" },
		["<CR>"] = { "accept", "fallback" },
		["<S-Tab>"] = { "show" },
		["<S-j>"] = { "select_next", "fallback" },
		["<S-k>"] = { "select_prev", "fallback" },
	},
	completion = {
		menu = {
			auto_show = true,
			draw = {
				treesitter = { "lsp" },
				columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
			},
		},
		documentation = { auto_show = true },
	},
	signature = { enabled = true },
	fuzzy = { implementation = "lua" },
	sources = {
		default = {
			"lsp",
			"path",
			"snippets",
			"buffer",
		},
		per_filetype = {
			sql = { "lsp", "snippets", "buffer" },
		},
		providers = {
			lsp = {
				score_offset = 90,
			},
		},
	},
})
