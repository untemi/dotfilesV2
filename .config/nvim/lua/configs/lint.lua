local lint = require "lint"

lint.linters_by_ft = {
  python = { "ruff" },
}

local lint_auggroup = vim.api.nvim_create_augroup("lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "BufReadPost", "InsertLeave" }, {
  group = lint_auggroup,
  callback = function()
    lint.try_lint()
  end,
})
