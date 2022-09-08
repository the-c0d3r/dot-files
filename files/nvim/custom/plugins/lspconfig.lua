local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local servers = { 
  "html", "cssls", "clangd", "jsonls", "pyright", "ansiblels", "bashls",
  "dockerls", "jedi_language_server", "jsonls", "pylsp", "luau_lsp"
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end
