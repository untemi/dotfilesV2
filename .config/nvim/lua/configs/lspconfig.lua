if vim.env.NO_LSP then
  return
end

require("nvchad.configs.lspconfig").defaults()

local servers = {
  "emmet_language_server",
  "html",
  "tailwindcss",
  "svelte",
  "templ",
  "taplo",
  "gopls",
  "rust_analyzer",
  "hyprls",
  "pyright",
  "slint_lsp",
  "gdscript",
  "graphql",
}

vim.lsp.enable(servers)

vim.lsp.config.html = {
  filetypes = { "html", "templ", "htmldjango" },
}

vim.lsp.emmet_language_server = {
  filetypes = { "html", "templ", "htmldjango" },
}

vim.lsp.tailwindcss = {
  settings = {
    tailwindCSS = {
      files = {
        exclude = {
          "**/.git/**",
          "**/node_modules/**",
          "**/.hg/**",
          "**/.svn/**",
          "**/target/**",
        },
      },
    },
  },
}
