return {
  {
    "mistweaverco/kulala.nvim",
    ft = { "http" },
    opts = {
      global_keymaps = true,
    },
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

      update_focused_file = {
        enable = false,
        update_root = {
          enable = false,
        },
        exclude = false,
      },

      filters = { custom = { "^.git$" } },
    },
  },

  {
    "mfussenegger/nvim-lint",
    event = "BufEnter",
    config = function()
      require "configs.lint"
    end,
  },

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
    "dundalek/bloat.nvim",
    cmd = "Bloat",
  },
}
