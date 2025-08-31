vim.lsp.enable { "json_ls" }

local mason = require "plugins.mason"
local conform = require "plugins.conform"
local treesitter = require "plugins.treesitter"

-- Install lsp language
vim.list_extend(mason.tools, { "json-lsp" })

-- Install Treesitter language
vim.list_extend(treesitter.ensure_installed, { "json" })
