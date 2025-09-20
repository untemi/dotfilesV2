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

-- HACK: set back terminal cursor
vim.api.nvim_create_autocmd("VimLeave", {
  command = "set guicursor=a:hor20",
})

-- fix the snipped jump
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    if
      require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
      and not require("luasnip").session.jump_active
    then
      require("luasnip").unlink_current()
    end
  end,
})
