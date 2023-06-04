local highlights = require "custom.highlights"
local M = {}

M.treesitter = {
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
    indent = {
        enable = true,
        disable = {
            "python"
        },
    },
}

M.mason = {
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
}

-- git support in nvimtree
M.nvimtree = {
    git = {
        enable = true,
    },
    renderer = {
        highlight_git = true,
        icons = {
            show = {
                git = false,
            },
        },
    },
}

return M
