vim.pack.add {
  { src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim" },
}

require("tiny-inline-diagnostic").setup {
  preset = "classic",
  transparent_bg = false,
  transparent_cursorline = false,

  hi = {
    error = "DiagnosticError",
    warn = "DiagnosticWarn",
    info = "DiagnosticInfo",
    hint = "DiagnosticHint",
    arrow = "NonText",
    background = "CursorLine",
    mixing_color = "None",
  },

  options = {
    show_sources = { enabled = false, if_many = false },
    use_icons_from_diagnostic = false,
    set_arrow_to_diag_color = false,
    add_messages = true,
    throttle = 20,
    softwrap = 30,
    multilines = { enabled = false, always_show = false },
    show_all_diags_on_cursorline = false,
    enable_on_insert = false,
    enable_on_select = false,
    overflow = { mode = "wrap", padding = 0 },
    break_line = { enabled = false, after = 30 },
    format = nil,
    virt_texts = { priority = 2048 },
    severity = {
      vim.diagnostic.severity.ERROR,
      vim.diagnostic.severity.WARN,
      vim.diagnostic.severity.INFO,
      vim.diagnostic.severity.HINT,
    },
    overwrite_events = nil,
  },

  disabled_ft = {},
}

vim.diagnostic.config { virtual_text = false }
