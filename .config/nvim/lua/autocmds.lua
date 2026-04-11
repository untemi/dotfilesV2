require "nvchad.autocmds"
local autocmd = vim.api.nvim_create_autocmd

-- HACK: set back terminal cursor
autocmd("VimLeave", {
  command = "set guicursor=a:hor20",
})

-- fix the snipped jump
autocmd("InsertLeave", {
  callback = function()
    if
      require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
      and not require("luasnip").session.jump_active
    then
      require("luasnip").unlink_current()
    end
  end,
})

-- nvdash
autocmd("BufDelete", {
  callback = function()
    local bufs = vim.t.bufs
    if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
      vim.cmd "Nvdash"
    end
  end,
})
