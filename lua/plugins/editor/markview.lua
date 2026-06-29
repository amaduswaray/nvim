local function heading(level)
	local fg = ("MarkviewPalette%dFg"):format(level)

	return {
		style = "icon",
		hl = fg,
		icon_hl = fg,
		sign_hl = fg,
	}
end

local function code_block_sign(buffer, item, fallback_language)
	local filetypes = require("markview.filetypes")
	local utils = require("markview.utils")
	local markdown = require("markview.renderers.markdown")

	local language = item.language or fallback_language or "text"
	local decorations = filetypes.get(language)

	if not decorations or not decorations.sign or decorations.sign == "" then
		return
	end

	vim.api.nvim_buf_set_extmark(buffer, markdown.ns, item.range.row_start, item.range.col_start, {
		undo_restore = false,
		invalidate = true,
		sign_text = decorations.sign,
		sign_hl_group = decorations.sign_hl and utils.set_hl(decorations.sign_hl) or nil,
	})
end

local function patch_query(language, patch)
	local files = vim.treesitter.query.get_files(language, "highlights")

	if #files == 0 then
		return
	end

	local sources = {}

	for _, path in ipairs(files) do
		local ok, lines = pcall(vim.fn.readfile, path)

		if ok then
			sources[#sources + 1] = table.concat(lines, "\n")
		end
	end

	if #sources == 0 then
		return
	end

	local source = table.concat(sources, "\n")
	local patched, changed = patch(source)

	if changed then
		vim.treesitter.query.set(language, "highlights", patched)
	end
end

vim.opt.signcolumn = "yes"

patch_query("markdown_inline", function(source)
	local patched, count = source:gsub("%s*%(code_span_delimiter%)", "", 1)

	return patched, count > 0
end)

patch_query("markdown", function(source)
	local patched, conceal_count = source:gsub('%s*%(#set! conceal ""%)', "")
	local conceal_lines_count

	patched, conceal_lines_count = patched:gsub('%s*%(#set! conceal_lines ""%)', "")

	return patched, (conceal_count + conceal_lines_count) > 0
end)

require("markview").setup({
	preview = {
		icon_provider = "internal",
		modes = { "n", "no", "c" },
		hybrid_modes = {},
	},

	markdown = {
		code_blocks = {
			enable = true,
		},

		metadata_minus = {
			enable = false,
		},
		metadata_plus = {
			enable = false,
		},

		headings = {
			shift_width = 0,

			heading_1 = heading(1),
			heading_2 = heading(2),
			heading_3 = heading(3),
			heading_4 = heading(4),
			heading_5 = heading(5),
			heading_6 = heading(6),

			setext_1 = {
				enable = false,
			},
			setext_2 = {
				enable = false,
			},
		},
	},

	markdown_inline = {
		inline_codes = {
			enable = false,
		},
	},

	yaml = {
		enable = false,
	},

	renderers = {
		markdown_code_block = function(buffer, item)
			code_block_sign(buffer, item, "text")
		end,

		markdown_indented_code_block = function(buffer, item)
			code_block_sign(buffer, item, "indented")
		end,
	},
})
