-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

-- fold configuration
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- vim.opt.foldcolumn = '2'
vim.opt.foldlevel = 1
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.foldnestmax = 1

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- vim tab width to 4 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- show invisible characters
vim.opt.list = true
vim.opt.listchars = { tab = '» ', extends = '›', precedes = '‹', trail = '·' }

