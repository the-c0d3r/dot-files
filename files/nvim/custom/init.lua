-- fold configuration
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.opt.foldcolumn = '2'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

-- show invisible characters
vim.opt.list = true
vim.opt.listchars = { tab = '» ', extends = '›', precedes = '‹', trail = '·' }
