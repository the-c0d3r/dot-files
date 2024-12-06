local present, cmp = pcall(require, "cmp")
local tabnine = require "cmp_tabnine.config"
local compare = require "cmp.config.compare"

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

tabnine:setup {
  max_lines = 1000,
  max_num_results = 20,
  sort = true,
  run_on_every_keystroke = true,
  snippet_placeholder = "..",
  show_prediction_strength = true,
}

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
      require "cmp_tabnine.compare",
    },
  },
  experimental = { ghost_text = true }, -- show autocomplete suggestions in grey text
  preselect = "none",
  completion = {
    completeopt = "menu,menuone,noinsert,noselect",
  },

  -- keyboard mappings for cmp
  mapping = {
    -- Confirm selections with right arrow
    ["<Right>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm { select = true }
      else
        fallback()
      end
    end, { "i" }),
    -- up down arrow keys to select
    ["<Down>"] = cmp.mapping(
      cmp.mapping.select_next_item {
        behavior = cmp.SelectBehavior.Select,
      },
      { "i" }
    ),
    ["<Up>"] = cmp.mapping(
      cmp.mapping.select_prev_item {
        behavior = cmp.SelectBehavior.Select,
      },
      { "i" }
    ),
    ["<C-j>"] = cmp.mapping(
      cmp.mapping.select_next_item {
        behavior = cmp.SelectBehavior.Select,
      },
      { "i" }
    ),
    ["<C-k>"] = cmp.mapping(
      cmp.mapping.select_prev_item {
        behavior = cmp.SelectBehavior.Select,
      },
      { "i" }
    ),
  },
}
