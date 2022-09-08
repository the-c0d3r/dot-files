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
  },

  user = {
    ["simrat39/symbols-outline.nvim"] = {
       require("symbols-outline").setup(),
    },
    ["neovim/nvim-lspconfig"] = {
      config = function()
        require "plugins.configs.lspconfig"
        require "custom.plugins.lspconfig"
      end,
    },
    ["goolord/alpha-nvim"] = {
       disable = false,
    },
    ["folke/which-key.nvim"] = {
        disable = false,
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
       require('neoscroll').setup(),
    },
  },
}

return M
