return {
  "catppuccin/nvim",
  "NvChad/nvim-colorizer.lua",
  "stevearc/oil.nvim",
  --"echasnovski/mini.pick",
  { 'nvim-mini/mini.pick', version = false },
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      picker = {
        enabled = true
      }
    },
    keys = {
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Find Buffers" },
      { "<leader>fg", function() Snacks.picker.grep() end, desc = "Find Grep" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = " Find Recent" },
      { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
      { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
    }
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
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

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end
      end,
    },
  },
  "neovim/nvim-lspconfig",
  "arnamak/stay-centered.nvim",
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
    }
  },
{
	"lukas-reineke/indent-blankline.nvim",
	--event = "LazyFile",
	opts = {
		indent = {
			char = "│",
			tab_char = "│",
		},
		scope = { enabled = false },
		exclude = {
			filetypes = {
				"help",
				"alpha",
				"dashboard",
				"neo-tree",
				"NvimTree",
				"Trouble",
				"trouble",
				"lazy",
				"mason",
				"notify",
				"toggleterm",
				"lazyterm",
			},
		},
	},
	main = "ibl",
},
{
	"echasnovski/mini.indentscope",
	version = false,
	opts = {
		symbol = "│",
		options = { try_as_border = true },
	},
	init = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"help",
				"alpha",
				"dashboard",
				"neo-tree",
				"NvimTree",
				"Trouble",
				"trouble",
				"lazy",
				"mason",
				"notify",
				"toggleterm",
				"lazyterm",
			},
			callback = function()
				vim.b.miniindentscope_disable = true
			end,
		})
	end,
}
}
