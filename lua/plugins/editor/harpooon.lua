local harpoon = require("harpoon")

-- Initialize Harpoon
harpoon.setup({
	menu = {
		width = vim.api.nvim_win_get_width(0) - 4,
	},
	settings = {
		save_on_toggle = true,
	},
})

-- Keybindings
vim.keymap.set("n", "<leader>H", function()
	harpoon:list():add()
end, { desc = "Harpoon File" })

vim.keymap.set("n", "<leader>h", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon Quick Menu" })

-- File navigation 1-5
for i = 1, 5 do
	vim.keymap.set("n", "<leader>" .. i, function()
		harpoon:list():select(i)
	end, { desc = "Harpoon to File " .. i })
end
