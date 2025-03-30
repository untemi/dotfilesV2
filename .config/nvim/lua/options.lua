require "nvchad.options"

local o = vim.o
local opt = vim.opt
local api = vim.api

o.relativenumber = true
o.mousemodel = "extend"

o.foldenable = true
o.foldlevel = 99
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- o.foldtext = ""
opt.fillchars:append { fold = " " }

api.nvim_create_autocmd("BufWinLeave", {
  pattern = "*",
  command = "silent! mkview",
})
api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  command = "silent! loadview",
})
