local M = {}

-- Legends
-- <leader> = space
-- <C-x>    = Ctrl + x
-- <S-x>    = Shift + x

M.general = {
    n = {
        -- ctrl keys
        -- ctrl + o and ctrl + i is reserved for default jumplist jumps
        ["<C-q>"] = { "<cmd>Telescope live_grep <CR>", "Open Telescope find string" },
        ["<C-x>"] = { "<cmd>qa<CR>", "quit all" },
        ["<C-t>"] = { "<cmd>SymbolsOutline<CR>", "Open symbols outline" },
        ["<C-s>"] = { "<cmd>w<CR>", "save" },
        ["<C-/>"] = { "<cmd>nohl<CR>", "Remove current search highlight" },

        -- Packer keymaps
        ["<leader>ps"] = { "<cmd>PackerSync<CR>", "Packer sync" },
        ["<leader>pc"] = { "<cmd>PackerCompile<CR>", "Packer compile" },
        ["<leader>pS"] = { "<cmd>PackerStatus<CR>", "Packer status" },
        -- mason keymaps
        ["<leader>pm"] = { "<cmd>Mason<CR>", "Mason Installer" },

        -- rename
        ["<leader>re"] = { ":IncRename ", "Trigger rename window" },

        -- misc
        ["<leader>o"] = { "<cmd>Telescope find_files <CR>", "Telescope find files" },
        ["<leader>fn"] = { "<cmd>enew<CR>", "New File" },
        ["<leader>gl"] = { "<cmd>LazyGit<CR>", "LazyGit" },

        -- window splits
        ["-"] = { "<cmd>split<CR>", "Split horizontally" },
        ["_"] = { "<cmd>vsplit<CR>", "Split vertically" },
        [";"] = { ":", "enter cmdline", opts = { nowait = true } },

        -- tab navigation
        ["<S-l>"] = {
            function()
                require("nvchad_ui.tabufline").tabuflineNext()
            end,
            "goto next buffer",
        },
        ["<S-h>"] = {
            function()
                require("nvchad_ui.tabufline").tabuflinePrev()
            end,
            "goto prev buffer",
        },

        -- hop plugin keymapping
        ["<C-g>"] = { "<cmd> HopLineStart<CR>", "Hop to Line" },
        ["f"] = { "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
            "Forward search" },
        ["F"] = {
            "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
            "Backward search"
        },
        ["t"] = {
            "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>",
            "Forward Search until"
        },
        ["T"] = {
            "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>",
            "Backward Search until"
        },
    }
}

return M
