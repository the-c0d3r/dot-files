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

-- load theme
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

-- tell kitty we're in an editor so it passes cmd+l through (see kitty.nix)
local function kitty_set_var(seq)
  if vim.api.nvim_ui_send then
    vim.api.nvim_ui_send(seq)
  else
    io.stdout:write(seq)
  end
end
vim.api.nvim_create_autocmd({ "VimEnter", "VimResume", "UIEnter" }, {
  callback = function() kitty_set_var "\x1b]1337;SetUserVar=in_editor=MQ==\007" end,
})
vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
  callback = function() kitty_set_var "\x1b]1337;SetUserVar=in_editor\007" end,
})
