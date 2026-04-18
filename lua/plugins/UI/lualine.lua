
			local colors = {
				blue = "#80a0ff",
				black = "#080808",
				white = "#c6c6c6",
				red = "#ff5189",
				violet = "#d183e8",
				green = "#A6E3A1",
				orange = "#FAB387",
				pink = "#F5C2E7",
				transparant = "NONE",
			}

			local amavim = {
				normal = {
					a = { fg = colors.pink, bg = colors.transparant, gui = "bold" },
					b = { fg = colors.white, bg = colors.transparant },
					c = { fg = colors.white, bg = colors.transparant },
				},
				command = {
					a = { fg = colors.orange, bg = colors.transparant, gui = "bold" },
					b = { fg = colors.white, bg = colors.transparant },
					c = { fg = colors.white, bg = colors.transparant },
				},

				terminal = {
					a = { fg = colors.violet, bg = colors.transparant, gui = "bold" },
					b = { fg = colors.white, bg = colors.transparant },
					c = { fg = colors.white, bg = colors.transparant },
				},

				insert = { a = { fg = colors.green, bg = colors.transparant, gui = "bold" } },
				visual = { a = { fg = colors.blue, bg = colors.transparant, gui = "bold" } },
				replace = { a = { fg = colors.red, bg = colors.transparant, gui = "bold" } },

				inactive = {
					a = { fg = colors.white, bg = colors.black },
					b = { fg = colors.white, bg = colors.black },
					c = { fg = colors.white, bg = colors.transparant },
				},
			}

			local function lsp()
				local msg = "NONE"
				local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
				local clients = vim.lsp.get_clients()
				if next(clients) == nil then
					return msg
				end
				for _, client in pairs(clients) do
					local filetypes = client.config.filetypes
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						return client.name
					end
				end
				return msg
			end

			require("lualine").setup({
				options = {
					theme = amavim,
					component_separators = "",
					section_separators = { left = " ", right = " " },
					globalstatus = true,
				},
				sections = {
					lualine_a = { { "mode", right_padding = 2, icon = "" } },

					lualine_b = {},

					lualine_c = {
						-- { "filetype", colored = true, icon_only = true },
						{ "branch", icon = "" },
						{ "diagnostics" },
					},

					lualine_x = {
						{ "diff", symbols = { added = "+", modified = "~", removed = "-" } },
						{ lsp, icon = "  LSP ~" },
						{ "location" },
					},

					lualine_y = {},

					lualine_z = {
						{ "progress", separator = { right = "" }, padding = { left = 1, right = 1 } },
					},
				},
				extensions = { "lazy" },
			})
