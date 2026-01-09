-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

-- EXAMPLE
local servers = {
  "ansiblels",
  "bashls",
  "clangd",
  -- "cssls",
  "dockerls",
  "html",
  "jsonls",
  "luau_lsp",
  "pylsp",
  -- "llm_ls",
}
vim.lsp.enable(servers)
