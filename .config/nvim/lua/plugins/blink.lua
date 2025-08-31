vim.pack.add {
  { src = "https://github.com/saghen/blink.cmp" },
  { src = "https://github.com/L3MON4D3/LuaSnip" },
}

require("blink.cmp").setup {
  signature = { enabled = true },
  keymap = { preset = "enter" },
  snippets = { preset = "luasnip" },
  appearance = {
    use_nvim_cmp_as_default = false,
    nerd_font_variant = "normal",
  },
  sources = {
    default = { "lazydev", "lsp", "path", "snippets", "buffer" },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      },
      cmdline = { min_keyword_length = 2 },
    },
  },
  cmdline = {
    enabled = true,
    completion = { menu = { auto_show = true } },
    keymap = { ["<CR>"] = { "accept_and_enter", "fallback" } },
  },
  completion = {
    menu = {
      border = nil,
      scrolloff = 1,
      scrollbar = false,
      draw = {
        columns = {
          { "kind_icon" },
          { "label", "label_description", gap = 1 },
          { "kind" },
          { "source_name" },
        },
      },
    },
    documentation = {
      window = {
        border = nil,
        scrollbar = false,
        winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
      },
      auto_show = true,
      auto_show_delay_ms = 500,
    },
  },
  fuzzy = { implementation = "lua" },
}
