vim.lsp.enable { "groovy" }

local treesitter = require "plugins.treesitter"
local mason = require "plugins.mason"

-- Install Treesitter language
vim.list_extend(treesitter.ensure_installed, { "groovy" })

-- Install lsp language
vim.list_extend(mason.tools, { "groovy-language-server", "stylua" })

-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--   group = vim.api.nvim_create_augroup("jenkinsfile_detect", { clear = true }),
--   pattern = { "Jenkinsfile" },
--   callback = function() vim.cmd "set filetype=groovy" end,
-- })
