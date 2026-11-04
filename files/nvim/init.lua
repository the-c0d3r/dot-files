vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme (the cached theme overwrites the 'background' nvim detected from the terminal)
local term_bg = vim.o.background
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

-- vim tab width to 4 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- show invisible characters
vim.opt.list = true
vim.opt.listchars = { tab = '» ', extends = '›', precedes = '‹', trail = '·' }

-- follow the terminal's light/dark (macOS appearance via kitty); nvim updates 'background' on its reports
local function follow_background(bg)
  local opts = require("nvconfig").base46
  local theme = bg == "light" and opts.theme_toggle[1] or opts.theme_toggle[2]
  if opts.theme ~= theme then
    opts.theme = theme
    require("base46").load_all_highlights()
  end
end
vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function() follow_background(vim.v.option_new) end,
})
follow_background(term_bg)
