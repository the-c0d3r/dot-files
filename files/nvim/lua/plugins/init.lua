return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "ansible-language-server",
        "bash-language-server",
        "clangd",
        "cmake-language-server",
        "html-lsp",
        "json-lsp",
        "lua-language-server",
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
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "vim",
        "yaml",
      },
    },
  },
  -- lsp for syntax highlight
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- outline for symbols
  {
    "simrat39/symbols-outline.nvim",
    lazy = false,
    config = function()
      require("symbols-outline").setup {
        lsp_blacklist = { "jsonls", "yamlls" },
      }
    end,
  },

  -- jump between lines
  {
    "phaazon/hop.nvim",
    lazy = false,
    config = function()
      require("hop").setup()
    end,
  },

  -- smooth scrolling
  {
    "karb94/neoscroll.nvim",
    lazy = false,
    config = function()
      require("neoscroll").setup()
    end,
  },

  -- show marks
  {
    "chentoast/marks.nvim",
    lazy = false,
    config = function()
      require("marks").setup()
    end,
  },

  -- cursorline highlight, highlight same keywords as cursor
  { "RRethy/vim-illuminate" },

  -- diff view
  {
    "sindrets/diffview.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    after = "plenary.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewFileHistory",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
    },
    config = function()
      require("diffview").setup()
    end,
  },

  -- tabnine AI assisted code completion
  {
    "tzachar/cmp-tabnine",
    lazy = false,
    after = "nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-calc" },
      { "hrsh7th/cmp-path" },
      { "f3fora/cmp-spell" },
      { "hrsh7th/cmp-emoji" },
      { "octaltree/cmp-look" },
      { "hrsh7th/nvim-cmp" },
    },
    build = "./install.sh",
    config = function()
      require "configs.tabnine"
    end,
  },

  -- auto session
  {
    "rmagatti/auto-session",
    lazy = false,
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = { "~/Downloads", "/" },
      }
    end,
  },

  -- pretty fold
  {
    "anuvyklack/pretty-fold.nvim",
    lazy = false,
    config = function()
      require("pretty-fold").setup()
    end,
  },

  -- source code analysis and navigation tool
  {
    "ray-x/guihua.lua",
    build = "cd lua/fzy && make",
  },
  -- show lsp signature while typing functions and arguments
  {
    "ray-x/lsp_signature.nvim",
    lazy = false,
    config = function()
      require("lsp_signature").setup {
        floating_window_above_cur_line = false,
      }
    end,
  },
  -- lsp references/definitions navigator
  {
    "ray-x/navigator.lua",
    lazy = false,
    after = "nvim-lspconfig",
    config = function()
      require("navigator").setup {
        lsp = {
          -- need to disable lsp here, as mason will install and handle it
          disable_lsp = { "all" },
          -- format on save will cause issues if the code is not compatible, like windows c programs
          format_on_save = false,
          document_highlight = false, -- LSP reference highlight
          disply_diagnostic_qf = false,
          tsserver = {
            filetypes = { "json", "yaml" }, -- Disable for Json as the lsp does not have codelens
          },
          diagnostic = {
            underline = true,
            virtual_text = true, -- show virtual for diagnostic message
            update_in_insert = false, -- update diagnostic message in insert mode
          },
        },
      }
    end,
  },

  -- new UI stuff, like popup cmdline window, and notifications
  {
    "folke/noice.nvim",
    lazy = false,
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    after = {
      "nui.nvim",
      "nvim-lspconfig",
    },
    config = function()
      require("noice").setup {
        presets = { inc_rename = true },
        lsp = {
          signature = { enabled = false },
          hover = { enabled = false },
        },
      }
    end,
  },

  -- highlights for TODO: and stuff
  {
    "folke/todo-comments.nvim",
    lazy = false,
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {}
    end,
  },

  -- themes
  { "EdenEast/nightfox.nvim" },

  -- context
  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = false,
    dependencies = "nvim-treesitter/nvim-treesitter",
    after = "nvim-treesitter",
    config = function()
      require("treesitter-context").setup {}
    end,
  },

  -- rename
  {
    "smjonas/inc-rename.nvim",
    lazy = false,
    config = function()
      require("inc_rename").setup {}
    end,
  },

  -- lazygit
  {
    "kdheepak/lazygit.nvim",
    lazy = false,
  },

  -- sidebar cursor animation
  {
    "gen740/SmoothCursor.nvim",
    lazy = false,
    config = function()
      require("smoothcursor").setup {
        fancy = { enable = true },
      }
    end,
  },

  -- hex editor
  {
    "RaafatTurki/hex.nvim",
    lazy = false,
    config = function()
      require("hex").setup()
    end,
  },

  -- file management
  {
    "stevearc/oil.nvim",
    lazy = false,
    config = function()
      require("oil").setup()
    end,
  },

  -- pets
  {
    "giusgad/pets.nvim",
    dependencies = {
      { "MunifTanjim/nui.nvim" },
      { "giusgad/hologram.nvim" },
    },
    config = function()
      require("pets").setup()
    end,
  },

  -- refactoring
  {
    "Wansmer/sibling-swap.nvim",
    lazy = false,
    dependencies = { "nvim-treesitter" },
    config = function()
      require("sibling-swap").setup()
    end,
  },

  -- annotation, doxygen generator
  {
    "danymat/neogen",
    lazy = false,
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
  },
}
