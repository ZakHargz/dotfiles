vim.lsp.enable { "dockerls" }

local treesitter = require "plugins.treesitter"
local mason = require "plugins.mason"

-- Install Treesitter language
vim.list_extend(treesitter.ensure_installed, { "dockerfile" })

-- Install lsp language
vim.list_extend(mason.tools, { "docker-language-server" })
