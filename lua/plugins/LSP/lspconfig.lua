vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf }
		-- TODO: Set snacks picker for gd, gR, gi -- This is on orgbrain version
		opts.desc = "Show LSP definitions"
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

		opts.desc = "Go to declaration"
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

		opts.desc = "Show LSP references"
		vim.keymap.set("n", "gR", vim.lsp.buf.references, opts)

		opts.desc = "Hover"
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover({ border = "rounded", max_height = 35, max_width = 120 })
		end, opts)

		opts.desc = "Show LSP implementations"
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

		opts.desc = "Rename"
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

		opts.desc = "Restart LSP"
		vim.keymap.set("n", "<leader>rs", "<CMD>LspRestart<CR>", opts)

		opts.desc = "Show line diagnostics"
		vim.keymap.set("n", "<leader>d", function()
			vim.diagnostic.open_float({
				border = "rounded",
			})
		end, opts)

		opts.desc = "Go to next diagnostic"
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, opts)

		opts.desc = "Go to prev diagnostic"
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, opts)

		opts.desc = "See available code actions"
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

		vim.keymap.set("n", "<leader>li", function()
			if vim.bo.filetype == "typescript" or vim.bo.filetype == "typescriptreact" then
				vim.lsp.buf.code_action({
					apply = true,
					---@diagnostic disable-next-line: assign-type-mismatch
					context = { only = { "source.removeUnused.ts" }, diagnostics = {} },
				})
				vim.defer_fn(function()
					vim.lsp.buf.format({ timeout_ms = 10000 })
				end, 100) -- 100ms delay
			else
				vim.lsp.buf.format({ timeout_ms = 10000 })
			end
		end)
	end,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

local blink_cmp = require("blink.cmp")
local capabilities = blink_cmp.get_lsp_capabilities()

-- LSPS
vim.lsp.enable({
	"lua_ls",
	"ts_ls",
	"gopls",
	"eslint",
	"tailwindcss",
	"jsonls",
	"svelte",
	"marksman",
	"cssls",
	"rust_analyzer",
	"elixirls",
	"clangd",
	"zls",
})

vim.lsp.config("lua_ls", {
	capabilities = capabilities,
	settings = { -- custom settings for lua
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})
