local luasnip = require('luasnip')
luasnip.config.setup({
  history = true,
  updateevents = 'TextChanged,TextChangedI',
  ext_opts = {
    [require('luasnip.util.types').choiceNode] = {
      active = {
        virt_text = { { '●', 'LspDiagnosticsSignInformation' } },
      },
    },
  },
})


local cmp = require('cmp')
local shared_config = {
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable,
    ["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
    ["<cr>"] = cmp.mapping.confirm({ select = true }),
    ["<TAB>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  formatting = {
    format = require('lspkind').cmp_format({ with_text = true }),
  },
  experimental = {
    ghost_text = true,
  },
}

cmp.setup(vim.tbl_deep_extend('force', shared_config, {
  sources = {
    { name = 'luasnip', priority = 100 },
    { name = 'nvim_lsp', priority = 90 },
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lua', priority = 90 },
    { name = 'fish' },
    { name = 'path', priority = 5 },
    { name = 'buffer', priority = 1 },
  },
}))

cmp.setup.cmdline(':', vim.tbl_deep_extend('force', shared_config, { sources = { { name = 'cmdline' } } }))
cmp.setup.cmdline('/', vim.tbl_deep_extend('force', shared_config, { sources = { { name = 'buffer' } } }))
