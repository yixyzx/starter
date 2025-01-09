-- EXAMPLE 
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
-- 1. ':Mason' to select and install lsp server
-- 2. add the lsp server into 'servers' the following:
-- 3. verify: edit file, and ':LspInfo' or ':checkhealth lsp' to check.
-- "pyflakes" do not support. Need set up manually.
local servers = { "html", "cssls", "clangd", "pyright" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- typescript
-- tsserver is deprecated, use ts_ls instead. Feature will be removed in lspconfig 0.2.1
-- lspconfig.tsserver.setup {
lspconfig.ts_ls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}
