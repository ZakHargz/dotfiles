vim.lsp.enable { "ts_ls" }

vim.pack.add {
  { src = "https://github.com/dmmulroy/ts-error-translator.nvim" },
}

local mason = require "plugins.mason"
local conform = require "plugins.conform"
local treesitter = require "plugins.treesitter"

-- Install lsp language
vim.list_extend(mason.tools, { "typescript-language-server", "biome", "eslint_d" })

-- Install Treesitter language
vim.list_extend(treesitter.ensure_installed, { "typescript", "tsx" })

-- Setup conform
conform.opts.formatters_by_ft.typescript = { "biome" }
conform.opts.formatters_by_ft.typescriptreact = { "biome" }
conform.opts.formatters_by_ft.javascript = { "biome" }
conform.opts.formatters_by_ft.javascriptreact = { "biome" }
conform.opts.formatters_by_ft.tsx = { "biome" }

require("ts-error-translator").setup {}
