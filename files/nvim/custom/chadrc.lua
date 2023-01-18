local M = {}

M.ui = {
    hl_override = {
        Comment = { italic = true },

        -- highlight current line
        CursorLine = { bg = "one_bg", },
    },
    theme = "tokyonight",
    theme_toggle = { "tokyonight", "gruvbox_light" },
}

M.mappings = {
    keys = {
        n = {
            ["<C-o>"] = { "<cmd> Telescope find_files <CR>", "Open Telescope find files" },
            ["<C-q>"] = { "<cmd> Telescope live_grep <CR>", "Open Telescope find string" },
            ["<C-p>"] = { "<cmd> PackerSync<CR>", "Packer Sync" },
            -- ["<C-h>"] = { "<cmd> HopLineStart<CR>", "Hop to Line" },
            ["<C-x>"] = { "<cmd> qa<CR>", "quit all" },
            ["<C-t>"] = { "<cmd> SymbolsOutline<CR>", "Open symbols outline" },
            ["<C-s>"] = { "<cmd> :w<CR>", "save" },

            [";"] = { ":", "enter cmdline", opts = { nowait = true } },
            ["<leader>re"] = { ":IncRename ", "Trigger rename window" },

            -- hop plugin keymapping
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
}

M.plugins = {
    override = {
        ["NvChad/ui"] = {
            statusline = {
                separator_style = "block", -- default/round/block/arrow
            },
            tabufline = {
                enabled = true,
                lazyload = false,
            },
        },

        ["williamboman/mason.nvim"] = {
            ensure_installed = {
                -- lua stuff
                "lua-language-server",
                "yaml-language-server",
                "python-lsp-server",
                "pyright",
                "clangd",
                "ansible-language-server",
                "lua-language-server",
                "stylua",
                "json-lsp",
                "html-lsp",
                "cmake-language-server",
                "bash-language-server",

                -- web dev
                "css-lsp",
                "html-lsp",
                "json-lsp",

                -- shell
                "shfmt",
                "shellcheck",
            },
        },
    },

    user = {
        -- dashboard
        ["goolord/alpha-nvim"] = {
            disable = false,
        },
        -- key hint prompt
        ["folke/which-key.nvim"] = {
            disable = false,
        },
        -- LSP configuration
        ["neovim/nvim-lspconfig"] = {
            config = function()
                require "plugins.configs.lspconfig"
                require "custom.plugins.lspconfig"
            end,
        },

        -- outline for symbols
        ["simrat39/symbols-outline.nvim"] = {
            config = function()
                require("symbols-outline").setup({
                    lsp_blacklist = { 'jsonls', 'yamlls' },
                })
            end,
        },

        -- jump between lines
        ['phaazon/hop.nvim'] = {
            config = function()
                require('hop').setup()
            end,
        },

        -- smooth scrolling
        ['karb94/neoscroll.nvim'] = {
            config = function()
                require('neoscroll').setup()
            end,
        },
        -- show marks
        ['chentoast/marks.nvim'] = {
            config = function()
                require('marks').setup()
            end,
        },
        -- cursorline highlight, highlight same keywords as cursor
        ['RRethy/vim-illuminate'] = {},

        -- -- fold provider
        -- ['kevinhwang91/promise-async'] = {},
        -- ['kevinhwang91/nvim-ufo'] = {
        --     config = function()
        --         require('ufo').setup()
        --     end,
        -- },
        -- -- prettify folded code
        -- ['anuvyklack/pretty-fold.nvim'] = {
        --     after = 'nvim-ufo',
        --     config = function()
        --         require('pretty-fold').setup()
        --     end,
        -- },

        -- diff view
        ['sindrets/diffview.nvim'] = {
            requires = {
                { 'nvim-lua/plenary.nvim' },
                { 'kyazdani42/nvim-web-devicons' }
            },
            after = 'plenary.nvim',
            cmd = {
                'DiffviewOpen',
                'DiffviewFileHistory',
                'DiffviewClose',
                'DiffviewToggleFiles',
                'DiffviewFocusFiles',
                'DiffviewRefresh'
            },
            config = function()
                require('diffview').setup()
            end,
        },

        -- show diagnostics, references, quick fixes
        ['folke/trouble.nvim'] = {
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
                require('trouble').setup()
            end,
        },

        -- cheatsheet for built-in commands, plugins, etc
        ["sudormrfbin/cheatsheet.nvim"] = {
            requires = {
                { 'nvim-telescope/telescope.nvim' },
                { 'nvim-lua/popup.nvim' },
                { 'nvim-lua/plenary.nvim' },
            },
        },

        -- tabnine AI assisted code completion
        ["tzachar/cmp-tabnine"] = {
            after = "nvim-cmp",
            requires = {
                { 'hrsh7th/cmp-buffer' },
                { 'hrsh7th/cmp-calc' },
                { 'hrsh7th/cmp-path' },
                { 'f3fora/cmp-spell' },
                { 'hrsh7th/cmp-emoji' },
                { 'octaltree/cmp-look' },
            },
            run = "./install.sh",
            config = function()
                require "custom.plugins.tabnine"
            end,
        },

        -- auto session
        ['rmagatti/auto-session'] = {
            config = function()
                require('auto-session').setup({
                    log_level = "error",
                    auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
                })
            end,
        },

        -- source code analysis and navigation tool
        ['ray-x/guihua.lua'] = {
            run = 'cd lua/fzy && make'
        },
        -- show lsp signature while typing functions and arguments
        ['ray-x/lsp_signature.nvim'] = {
            config = function()
                require('lsp_signature').setup({
                    floating_window_above_cur_line = false,
                })
            end
        },
        -- lsp references/definitions navigator
        ['ray-x/navigator.lua'] = {
            after = "nvim-lspconfig",
            config = function()
                require('navigator').setup({
                    lsp = {
                        -- need to disable lsp here, as mason will install and handle it
                        disable_lsp = { 'all' },
                        -- format on save will cause issues if the code is not compatible, like windows c programs
                        format_on_save = false,
                        document_highlight = false, -- LSP reference highlight
                        disply_diagnostic_qf = false,
                        tsserver = {
                            filetypes = { 'json', 'yaml' } -- Disable for Json as the lsp does not have codelens
                        },
                    },
                    mason = true,
                })
            end,
        },

        -- new UI stuff, like popup cmdline window, and notifications
        ['folke/noice.nvim'] = {
            requires = {
                "MunifTanjim/nui.nvim",
            },
            after = {
                "nui.nvim",
                "nvim-lspconfig",
            },
            config = function()
                require("noice").setup({
                    presets = { inc_rename = true },
                    lsp = {
                        signature = { enabled = false },
                        hover = { enabled = false },
                    },
                })
            end,
        },

        -- highlights for TODO: and stuff
        ['folke/todo-comments.nvim'] = {
            requires = 'nvim-lua/plenary.nvim',
            config = function()
                require("todo-comments").setup {}
            end,
        },

        ['EdenEast/nightfox.nvim'] = {},

        -- context
        ['nvim-treesitter/nvim-treesitter-context'] = {
            requires = 'nvim-treesitter/nvim-treesitter',
            after = "nvim-treesitter",
            config = function()
                require("treesitter-context").setup {}
            end,
        },

        -- rename
        ['smjonas/inc-rename.nvim'] = {
            config = function()
                require("inc_rename").setup {}
            end,
        },
    },
}

return M
