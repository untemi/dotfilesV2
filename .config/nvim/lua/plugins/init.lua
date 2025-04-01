return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    opts = {},
    cmd = { "Typr", "TyprStats" },
  },

  { "jvgrootveld/telescope-zoxide", lazy = false },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = {
        width = 20,
      },
    },
  },
  {
    "karb94/neoscroll.nvim",
    lazy = false,
    opts = {

      mappings = {
        "<C-u>",
        "<C-d>",
        "<C-b>",
        "<C-f>",
        "<C-y>",
        "<C-e>",
        "zt",
        "zz",
        "zb",
      },
      duration_multiplier = 0.4,
      easing = "quadratic",
      ignored_events = {
        "WinScrolled",
        "CursorMoved",
      },
    },
  },

  {
    "mcauley-penney/visual-whitespace.nvim",
    config = true,
    keys = { "v", "V", "<C-v>" }, -- optionally, lazy load on visual mode keys
    opts = {
      highlight = { link = "Visual" },
      space_char = "·",
      tab_char = "→",
      nl_char = "↲",
      cr_char = "←",
      enabled = true,
      excluded = {
        filetypes = {},
        buftypes = {},
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    event = "BufEnter",
    config = function()
      require "configs.lint"
    end,
  },
}
