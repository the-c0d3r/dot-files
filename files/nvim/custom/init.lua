-- example file i.e lua/custom/init.lua
-- load your options globals, autocmds here or anything .__.
-- you can even override default options here (core/options.lua)


vim.api.nvim_set_keymap('i', 'jj', "<Esc>");

vim.opt.foldmethod="syntax"

require'lspconfig'.jedi_language_server.setup{}

