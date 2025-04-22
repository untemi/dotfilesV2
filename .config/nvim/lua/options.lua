require "nvchad.options"

local o = vim.o

o.relativenumber = true
o.mousemodel = "extend"

-- local api = vim.api
-- local opt = vim.opt
-- o.foldenable = true
-- o.foldlevel = 99
-- o.foldmethod = "manual"
-- o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- o.foldtext = ""
-- opt.fillchars:append { fold = " " }

-- api.nvim_create_autocmd("BufWinLeave", {
--   pattern = "*",
--   command = "silent! mkview",
-- })
--
-- api.nvim_create_autocmd("BufWinEnter", {
--   pattern = "*",
--   command = "silent! loadview",
-- })
