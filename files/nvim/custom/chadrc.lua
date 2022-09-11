local M = {}

M.ui = {
  theme = "onedark",
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

    -- display marks on the sidebar
    ['kshenoy/vim-signature'] = {},
    -- code alignment gaip+keyword, gaip=, gaip*
    ['junegunn/vim-easy-align'] = {},
    -- switches between source and header file
    ['vim-scripts/a.vim'] = {},
    -- multiple cursor location
    -- ['terryma/vim-multiple-cursors'] = {},
    ['easymotion/vim-easymotion'] = {},
    -- smooth scrolling
    ['karb94/neoscroll.nvim'] = {
      config = function()
        require('neoscroll').setup()
      end,
    },

    -- source code analysis and navigation tool
    ['ray-x/guihua.lua'] = {},
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
