local present, cmp = pcall(require, "cmp")
local tabnine = require('cmp_tabnine.config')
local compare = require('cmp.config.compare')

if not present then
    return
end

local sources = {
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "path" },
    -- { name = "copilot" },
    { name = "cmdline" },
    { name = "treesitter" },
    { name = "plugins" },
    { name = "cmp_tabnine" },
    { name = "calc" },
    -- { name = "spell" },
    -- { name = "emoji" },
    -- { name = "look" },
}

tabnine.setup({
    max_lines = 1000,
    max_num_results = 20,
    sort = true,
    run_on_every_keystroke = true,
    snippet_placeholder = '..',
    show_prediction_strength = true,
})

cmp.setup {
    sources = sources,
    sorting = {
        priority_weight = 2,
        comparators = {
            compare.offset,
            compare.exact,
            compare.score,
            compare.recently_used,
            compare.kind,
            compare.sort_text,
            compare.length,
            compare.order,
            require('cmp_tabnine.compare'),
        },
    },
    experimental = { ghost_text = true }, -- show autocomplete suggestions in grey text

    -- adds symbols for tabnine
    formatting = {
        format = function(entry, vim_item)
            local icons = require("nvchad_ui.icons").lspkind
            vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
            if entry.source.name == "cmp_tabnine" then
                local detail = (entry.completion_item.data or {}).detail
                vim_item.kind = "  TabNine"
                if detail and detail:find('.*%%.*') then
                    vim_item.kind = vim_item.kind .. '  ' .. detail
                end

                if (entry.completion_item.data or {}).multiline then
                    vim_item.kind = vim_item.kind .. '  ' .. '[ML]'
                end
            end
            local maxwidth = 80
            vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
            return vim_item
        end,
    },

    -- keyboard mappings for cmp
    mapping = {
        -- Confirm selections with right arrow
        ['<Right>'] = cmp.mapping(function(fallback)
            if cmp.visible()
            then cmp.confirm({ select = true })
            else fallback()
            end
        end, { 'i' }),
        -- up down arrow keys to select
        ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Select
        }), { 'i' }),
        ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Select
        }), { 'i' }),
        ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Select
        }), { 'i' }),
        ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Select
        }), { 'i' }),
    }
}
