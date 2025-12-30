require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- ctrl keys
-- ctrl + o and ctrl + i are reserved for default jumplist jumps
map("n", "<C-q>", "<cmd>Telescope live_grep <cr>")
map("n", "<C-t>", "<cmd>SymbolsOutline<cr>")
map("n", "<C-x>", "<cmd>qa<cr>")
map("n", "<C-/>", "<cmd>nohl<cr>")

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "<leader>re", ":IncRename")
map("n", "<leader>o", "<cmd>Telescope find_files<cr>")
map("n", "<leader>fn", "<cmd>enew<cr>")
map("n", "<leader>gl", "<cmd>LazyGit<cr>")
map("n", "-", "<cmd>split<cr>")
map("n", "_", "<cmd>vsplit<cr>")

-- Keyboard users
map("n", "<C-t>", function()
  require("menu").open "default"
end, {})

-- mouse users + nvimtree users!
map("n", "<RightMouse>", function()
  vim.cmd.exec '"normal! \\<RightMouse>"'

  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true })
end, {})


-- this fixes the issue where the llm.nvim causes issue when inserting tab in a new line
-- this is a workaround for the issue.
map("i", "<Tab>", function ()
    local llm = require('llm.completion')

    if llm.shown_suggestion ~= nil then
        llm.complete()
    else
        local keys = vim.api.nvim_replace_termcodes('<Tab>', true, false, true)
        vim.api.nvim_feedkeys(keys, 'n', false)
    end
end,
{ noremap = true, silent = true})
