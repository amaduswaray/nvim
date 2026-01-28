return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      disable_background = true,
      styles = {
        bold = false,
        italic = true,
        transparency = true,
      },
      highlight_groups = {
        LspInlayHint = { bg = "base", fg = "muted", italic = true },
        NotificationInfo = { bg = "none", fg = "text" },
        NotificationWarning = { bg = "none", fg = "subtle" },
        NotificationError = { bg = "none", fg = "love" },
      },
    },
    config = function(_, opts)
      require("rose-pine").setup(opts)
      vim.cmd("colorscheme rose-pine")
    end,
  },
  "NvChad/nvim-colorizer.lua",
  "stevearc/oil.nvim",
  "refractalize/oil-git-status.nvim",
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
      { "<leader>fg", function() Snacks.picker.grep({
        layout = "ivy"
      }) end, desc = "Find Grep" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = " Find Recent" },
      { "<leader>gs", function() Snacks.picker.git_status({
        layout = "telescope"
      }) end, desc = "Git Status" },
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
  },
  "Saghen/blink.cmp",
  {
    {
      "stevearc/conform.nvim",
      opts = {
        format_on_save = {
          timeout_ms = 8000,
          lsp_format = "fallback",
        },
        formatters_by_ft = {
          lua = { "stylua" },
          javascript = { "prettierd" },
          javascriptreact = { "prettierd" },
          typescript = { "prettierd" },
          typescriptreact = { "prettierd" },
          json = { "prettierd" },
        },
      },
    },
    {
      "windwp/nvim-ts-autotag",
      config = function()
        require("nvim-ts-autotag").setup()
      end,
    },
  },
}
