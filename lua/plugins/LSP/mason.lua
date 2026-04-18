		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")

		-- custom UI icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = " ",
					package_uninstalled = "✗",
				},
			},
		})

		-- setup LSPs
		mason_lspconfig.setup({
			ensure_installed = {
				"ts_ls",
				"lua_ls",
				"rust_analyzer",
				"gopls",
				"templ",
				"marksman",
				"intelephense",
				"tailwindcss",
				"cssls",
				"svelte",
				"eslint",
				"elixirls",
				"rnix",
				"clangd",
				"zls",
			},

			automatic_installation = true,
		})
