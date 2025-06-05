local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettierd" },
    json = { "prettierd" },
    htmldjango = { "prettierd" },
    html = { "prettierd", "rustywind" },
    go = { "gofumpt", "goimports-reviser", "golines" },
    templ = { "templ" },
    toml = { "taplo" },
    yaml = { "yamlfmt" },
    python = { "ruff" },
    rust = { "rustfmt" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
