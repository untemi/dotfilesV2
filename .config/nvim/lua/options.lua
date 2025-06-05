require "nvchad.options"

vim.o.relativenumber = true
vim.o.mousemodel = "extend"
vim.o.guifont = "JetBrainsMono Nerd Font:h12"
vim.opt.termguicolors = true

vim.notify = require "notify"

local gdproject = io.open(vim.fn.getcwd() .. "/project.godot", "r")
if gdproject then
  io.close(gdproject)
  vim.fn.serverstart "./godothost"
end
