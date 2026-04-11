if vim.env.NO_LSP then
  return
end

require("nvchad.configs.lspconfig").defaults()

local servers = {
  svelte = {},
  templ = {},
  taplo = {},
  gopls = {},
  rust_analyzer = {},
  hyprls = {},
  pyright = {},
  slint_lsp = {},
  gdscript = {},
  graphql = {},
  vtsls = {},
  zls = {},

  html = {
    filetypes = { "html", "templ", "htmldjango" },
  },
  emmet_language_server = {
    filetypes = { "html", "templ", "htmldjango" },
  },
  tailwindcss = {
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
  },
}

for name, opts in pairs(servers) do
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end
