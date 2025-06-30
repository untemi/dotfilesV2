require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del

nomap("n", "<C-s>")

map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "fd", "<cmd> Telescope zoxide list <cr>", { desc = "telescope zoxide" })
map("n", "K", require("pretty_hover").hover, { desc = "Lsp Hover" })
map("n", "<leader>ca", require("tiny-code-action").code_action, { silent = true, desc = "code actions" })
