require("Comment").setup({
	ignore = "^$",
	toggler = {
		line = "<leader>cc",
		block = "<leader>cb",
	},
	opleader = {
		line = "<leader>c",
		block = "<leader>c",
	},
	mappings = { basic = true, extra = false },
})
