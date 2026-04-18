local snacks = require("snacks")

snacks.setup({
	picker = {
		enabled = true,
	},
})

-- keymaps
local map = vim.keymap.set

map("n", "<leader>ff", function()
	snacks.picker.files()
end, { desc = "Find Files" })

map("n", "<leader>fb", function()
	snacks.picker.buffers({
		layout = "dropdown",
	})
end, { desc = "Find Buffers" })

map("n", "<leader>fg", function()
	snacks.picker.grep({
		layout = "ivy",
	})
end, { desc = "Find Grep" })

map("n", "<leader>fr", function()
	snacks.picker.recent()
end, { desc = "Find Recent" })

map("n", "<leader>gs", function()
	snacks.picker.git_status({
		layout = "telescope",
	})
end, { desc = "Git Status" })

map("n", "<leader>gl", function()
	snacks.picker.git_log()
end, { desc = "Git Log" })

map("n", "<leader>fD", function()
	snacks.picker.diagnostics({
		layout = "telescope",
	})
end, { desc = "Find Diagnostics" })

map("n", "<leader>fd", function()
	snacks.picker.diagnostics_buffer({
		layout = "telescope",
	})
end, { desc = "Buffer Diagnostics" })
