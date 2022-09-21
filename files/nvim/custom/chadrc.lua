local M = {}

M.ui = {
  theme = "onedark",
}

M.mappings = {
  keys = {
    n = {
      ["<C-o>"] = { "<cmd> Telescope find_files <CR>", "Open Telescope find files" },
      ["<C-q>"] = { "<cmd> Telescope live_grep <CR>", "Open Telescope find string" },
      ["<C-h>"] = { "<cmd> HopLine<CR>", "Hop to Line" }
    }
  }
}

M.plugins = {
  override = {
    ["NvChad/ui"] = {
      statusline = {
        separator_style = "arrow", -- default/round/block/arrow
        overriden_modules = nil,
      },

      -- lazyload it when there are 1+ buffers
      tabufline = {
        enabled = true,
        lazyload = false,
        overriden_modules = nil,
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

    -- outline for symbols
    ["simrat39/symbols-outline.nvim"] = {
      config = function()
        require("symbols-outline").setup()
      end,
    },
    -- LSP configuration
    ["neovim/nvim-lspconfig"] = {
      config = function()
        require "plugins.configs.lspconfig"
        require "custom.plugins.lspconfig"
      end,
    },

    -- code alignment gaip+keyword, gaip=, gaip*
    ['junegunn/vim-easy-align'] = {},
    -- multiple cursor location
    -- ['terryma/vim-multiple-cursors'] = {},
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

    -- cursorline highlight
    ['RRethy/vim-illuminate'] = {},

    -- prettify folded code
    ['anuvyklack/pretty-fold.nvim'] = {
      config = function()
        require('pretty-fold').setup()
      end,
    },

    -- fold provider
    ['kevinhwang91/promise-async'] = {},
    ['kevinhwang91/nvim-ufo'] = {
      config = function()
        require('ufo').setup()
      end,
    },

    -- diff view
    ['sindrets/diffview.nvim'] = {
      requires = "nvim-lua/plenary.nvim",
      after = 'plenary.nvim',
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
          },
          mason = true,
        })
      end,
    },
  },
}

return M
