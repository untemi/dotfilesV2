-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()
local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

local servers = {
  "html",
  "hyprls",
  "tailwindcss",
  "gopls",
  "templ",
  "svelte",
  "pyright",
  "rust_analyzer",
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.rust_analyzer.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        enable = true,
        command = "check",
      },
      cargo = {
        allFeatures = false,
        loadOutDirsFromCheck = true,
      },
      procMacro = {
        enable = false,
      },
      diagnostics = {
        enable = true,
        experimental = false,
      },
      imports = {
        granularity = {
          group = "module",
        },
      },
      completion = {
        autoimport = {
          enable = false,
        },
      },
    },
  },
}
-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
