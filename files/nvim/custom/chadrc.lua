local M = {}

M.ui = {
    hl_override = {
        Comment = { italic = true },

        -- highlight current line
        CursorLine = { bg = "one_bg", },
    },
    theme = "onedark",
}

M.mappings = {
    keys = {
        n = {
            ["<C-o>"] = { "<cmd> Telescope find_files <CR>", "Open Telescope find files" },
            ["<C-q>"] = { "<cmd> Telescope live_grep <CR>", "Open Telescope find string" },
            ["<C-p>"] = { "<cmd> Telescope project<CR>", "project menu" },
            ["<C-h>"] = { "<cmd> HopLineStart<CR>", "Hop to Line" },
            ["<C-x>"] = { "<cmd> qa<CR>", "quit all" },
            ["<leader>dh"] = {
                function()
                    vim.diagnostics.hide()
                end,
                "hide diagnostics",
            },
            ["<leader>ds"] = {
                function()
                    vim.diagnostics.show()
                end,
                "hide diagnostics",
            },
        }
    }
}

M.plugins = {
    override = {
        ["NvChad/ui"] = {
            statusline = {
                separator_style = "arrow", -- default/round/block/arrow
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
                require("symbols-outline").setup()
            end,
        },

        -- telescope project selection
        ['nvim-telescope/telescope-project.nvim'] = {
            requires = 'nvim-telescope/telescope.nvim',
            after = 'telescope.nvim',
            config = function()
                require 'telescope'.load_extension('project')
            end,
        },

        -- multiple cursor location
        -- ['mg979/vim-visual-multi'] = {},

        -- jump to match
        ['ggandor/leap.nvim'] = {
            config = function()
                require('leap').setup({
                    highlight_unlabeled = true,
                })
                require('leap').set_default_keymaps()
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

        -- fold provider
        ['kevinhwang91/promise-async'] = {},
        ['kevinhwang91/nvim-ufo'] = {
            config = function()
                require('ufo').setup()
            end,
        },
        -- prettify folded code
        ['anuvyklack/pretty-fold.nvim'] = {
            after = 'nvim-ufo',
            config = function()
                require('pretty-fold').setup()
            end,
        },

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
        ['ray-x/navigator.lua'] = {
            after = "nvim-lspconfig",
            config = function()
                require('navigator').setup({
                    lsp = {
                        -- need to disable lsp here, as mason will install and handle it
                        disable_lsp = { 'all' },
                        -- format on save will cause issues if the code is not compatible, like windows c programs
                        format_on_save = false,
                        document_highlight = false,
                    },
                    mason = true,
                })
            end,
        },
    },
}

return M
