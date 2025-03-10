require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "fd", "<cmd> Telescope zoxide list <cr>", { desc = "telescope zoxide" })
map("v", "p", "P")

nomap("n", "<C-s>")
