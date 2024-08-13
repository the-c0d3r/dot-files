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
