vim.lsp.enable { "lua_ls" }

local mason = require "plugins.mason"
local conform = require "plugins.conform"
local treesitter = require "plugins.treesitter"

-- Install lsp language
vim.list_extend(mason.tools, { "lua-language-server", "stylua" })

-- Install Treesitter language
vim.list_extend(treesitter.ensure_installed, { "lua", "luadoc" })

-- Setup conform
conform.opts.formatters_by_ft.lua = { "stylua" }
conform.opts.formatters.stylua = function(bufnr)
  return {
    exe = "stylua",
    args = {
      "--column-width",
      "120",
      "--quote-style",
      "AutoPreferDouble",
      "--indent-type",
      "Spaces",
      "--indent-width",
      "2",
      "--call-parentheses",
      "None",
      "--collapse-simple-statement",
      "Always",
      "--stdin-filepath",
      vim.api.nvim_buf_get_name(bufnr),
      "-",
    },
    stdin = true,
  }
end
