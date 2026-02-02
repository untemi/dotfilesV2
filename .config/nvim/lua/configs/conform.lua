local options = {
  formatters_by_ft = {
    rust = { "rustfmt" },
    go = { "gofumpt", "goimports-reviser", "golines" },
    zig = { "zigfmt" },
    lua = { "stylua" },
    python = { "ruff" },
    javascript = { "biome" },
    typescriptreact = { "biome" },

    toml = { "taplo" },
    yaml = { "yamlfmt" },
    bash = { "shfmt" },
    sh = { "shfmt" },

    htmldjango = { "prettierd" },
    html = { "biome", "rustywind" },
    templ = { "templ" },

    css = { "biome" },
    json = { "biome" },
    jsonc = { "biome" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
