require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del

nomap("n", "<C-s>")

map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "fd", "<cmd> Telescope zoxide list <cr>", { desc = "telescope zoxide" })

map("n", "!", function()
  require("nvchad.term").new { pos = "sp" }
end, { desc = "open term" })

map("t", "<Esc>", function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-d>", true, false, true), "t", false)
  vim.defer_fn(function()
    if vim.bo.buftype == "terminal" then
      vim.cmd "bd!"
    end
  end, 50)
end, { desc = "Exit and close terminal" })
