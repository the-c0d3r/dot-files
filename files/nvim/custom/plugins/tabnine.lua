local present, cmp = pcall(require, "cmp")
local tabnine = require('cmp_tabnine.config')

if not present then
    return
end

local sources = {
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "path" },
    { name = "copilot" },
    { name = "cmdline" },
    { name = "treesitter" },
    { name = "plugins" },
    { name = 'cmp_tabnine' },
}

tabnine.setup({
    max_lines = 1000,
    max_num_results = 20,
    sort = true,
    run_on_every_keystroke = true,
    snippet_placeholder = '..',
    ignored_file_types = {
        -- default is not to ignore
        -- uncomment to ignore in lua:
        -- lua = true
    },
    show_prediction_strength = true
})

cmp.setup {
    sources = sources,
}
