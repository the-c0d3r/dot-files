local M = {}

M.ui = {
    hl_add = {
        custom_btns = {
            bg = "blue", fg = "black"
        }
    },
    hl_override = {
        Comment = { italic = true },

        -- highlight current line
        CursorLine = { bg = "one_bg", },
    },
    theme = "tokyonight",
    theme_toggle = { "tokyonight", "gruvbox_light" },
}

M.mappings = require "custom.mappings"

M.plugins = {
    override = {
        ["NvChad/ui"] = {
            statusline = {
                separator_style = "block", -- default/round/block/arrow
            },
            tabufline = {
                enabled = true,
                lazyload = false,
                overriden_modules = function()
                    return require "custom.buttons"
                end,
            },
        },

        ["williamboman/mason.nvim"] = {
            ensure_installed = {
                "ansible-language-server",
                "bash-language-server",
                "clangd",
                "cmake-language-server",
                "html-lsp",
                "json-lsp",
                "lua-language-server",
                "pyright",
                "python-lsp-server",
                "stylua",
                "yaml-language-server",
                -- web dev
                "css-lsp",
                "html-lsp",
                "json-lsp",
                -- shell
                "shfmt",
                "shellcheck",
            },
        },

        ["nvim-treesitter/nvim-treesitter"] = {
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "css",
                "html",
                "javascript",
                "json",
                "lua",
                "python",
                "vim",
                "yaml",
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
                    lsp_blacklist = { "jsonls", "yamlls" },
                })
            end,
        },

        -- jump between lines
        ["phaazon/hop.nvim"] = {
            config = function()
                require("hop").setup()
            end,
        },

        -- smooth scrolling
        ["karb94/neoscroll.nvim"] = {
            config = function()
                require("neoscroll").setup()
            end,
        },
        -- show marks
        ["chentoast/marks.nvim"] = {
            config = function()
                require("marks").setup()
            end,
        },
        -- cursorline highlight, highlight same keywords as cursor
        ["RRethy/vim-illuminate"] = {},

        -- -- fold provider
        -- ["kevinhwang91/nvim-ufo"] = {
        --     requires = "kevinhwang91/promise-async",
        --     config = function()
        --         require("ufo").setup()
        --     end,
        -- },
        -- -- prettify folded code
        -- ["anuvyklack/pretty-fold.nvim"] = {
        --     after = "nvim-ufo",
        --     config = function()
        --         require("pretty-fold").setup()
        --     end,
        -- },

        -- diff view
        ["sindrets/diffview.nvim"] = {
            requires = {
                { "nvim-lua/plenary.nvim" },
                { "kyazdani42/nvim-web-devicons" }
            },
            after = "plenary.nvim",
            cmd = {
                "DiffviewOpen",
                "DiffviewFileHistory",
                "DiffviewClose",
                "DiffviewToggleFiles",
                "DiffviewFocusFiles",
                "DiffviewRefresh"
            },
            config = function()
                require("diffview").setup()
            end,
        },

        -- show diagnostics, references, quick fixes
        ["folke/trouble.nvim"] = {
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
                require("trouble").setup()
            end,
        },

        -- cheatsheet for built-in commands, plugins, etc
        ["sudormrfbin/cheatsheet.nvim"] = {
            requires = {
                { "nvim-telescope/telescope.nvim" },
                { "nvim-lua/popup.nvim" },
                { "nvim-lua/plenary.nvim" },
            },
        },

        -- tabnine AI assisted code completion
        ["tzachar/cmp-tabnine"] = {
            after = "nvim-cmp",
            requires = {
                { "hrsh7th/cmp-buffer" },
                { "hrsh7th/cmp-calc" },
                { "hrsh7th/cmp-path" },
                { "f3fora/cmp-spell" },
                { "hrsh7th/cmp-emoji" },
                { "octaltree/cmp-look" },
            },
            run = "./install.sh",
            config = function()
                require "custom.plugins.tabnine"
            end,
        },

        -- auto session
        ["rmagatti/auto-session"] = {
            config = function()
                require("auto-session").setup({
                    log_level = "error",
                    auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
                })
            end,
        },

        -- source code analysis and navigation tool
        ["ray-x/guihua.lua"] = {
            run = "cd lua/fzy && make"
        },
        -- show lsp signature while typing functions and arguments
        ["ray-x/lsp_signature.nvim"] = {
            config = function()
                require("lsp_signature").setup({
                    floating_window_above_cur_line = false,
                })
            end
        },
        -- lsp references/definitions navigator
        ["ray-x/navigator.lua"] = {
            after = "nvim-lspconfig",
            config = function()
                require("navigator").setup({
                    lsp = {
                        -- need to disable lsp here, as mason will install and handle it
                        disable_lsp = { "all" },
                        -- format on save will cause issues if the code is not compatible, like windows c programs
                        format_on_save = false,
                        document_highlight = false, -- LSP reference highlight
                        disply_diagnostic_qf = false,
                        tsserver = {
                            filetypes = { "json", "yaml" } -- Disable for Json as the lsp does not have codelens
                        },
                    },
                    mason = true,
                })
            end,
        },

        -- new UI stuff, like popup cmdline window, and notifications
        ["folke/noice.nvim"] = {
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
        ["folke/todo-comments.nvim"] = {
            requires = "nvim-lua/plenary.nvim",
            config = function()
                require("todo-comments").setup {}
            end,
        },

        -- themes
        ["EdenEast/nightfox.nvim"] = {},

        -- context
        ["nvim-treesitter/nvim-treesitter-context"] = {
            requires = "nvim-treesitter/nvim-treesitter",
            after = "nvim-treesitter",
            config = function()
                require("treesitter-context").setup {}
            end,
        },

        -- rename
        ["smjonas/inc-rename.nvim"] = {
            config = function()
                require("inc_rename").setup {}
            end,
        },

        -- lazygit
        ["kdheepak/lazygit.nvim"] = {},

        -- sidebar cursor animation
        ["gen740/SmoothCursor.nvim"] = {
            config = function()
                require("smoothcursor").setup({
                    fancy = { enable = true, },
                })
            end,
        },

        -- hex editor
        ["RaafatTurki/hex.nvim"] = {},

        -- file management
        ["stevearc/oil.nvim"] = {
            config = function()
                require("oil").setup()
            end,
        },

        -- pets
        ["giusgad/pets.nvim"] = {
            requires = {
                { "MunifTanjim/nui.nvim" },
                { "giusgad/hologram.nvim" },
            },
            config = function()
                require("pets").setup()
            end,
        },

        -- refactoring
        ["Wansmer/sibling-swap.nvim"] = {
            requires = { "nvim-treesitter" },
            config = function()
                require("sibling-swap").setup()
            end,
        },
    },
}

return M
