local gitsigns = require("gitsigns")

gitsigns.setup({
	signs = {
		add = { text = "▎" },
		change = { text = "▎" },
		delete = { text = "" },
		topdelete = { text = "" },
		changedelete = { text = "▎" },
		untracked = { text = "▎" },
	},

	on_attach = function(buffer)
		local gs = package.loaded.gitsigns

		local function map(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, {
				buffer = buffer,
				desc = desc,
			})
		end

		-- example mappings (optional, since your original had none yet)
		map("n", "]h", gs.next_hunk, "Next Hunk")
		map("n", "[h", gs.prev_hunk, "Prev Hunk")
		map("n", "<leader>hs", gs.stage_hunk, "Stage Hunk")
		map("n", "<leader>hr", gs.reset_hunk, "Reset Hunk")
		map("n", "<leader>hp", gs.preview_hunk, "Preview Hunk")
	end,
})
