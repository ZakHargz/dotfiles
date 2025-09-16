vim.lsp.enable { "terraform_ls", "opentofu" }

local mason = require "plugins.mason"
local conform = require "plugins.conform"
local treesitter = require "plugins.treesitter"

-- Install lsp language
vim.list_extend(mason.tools, { "terraform", "terraform-ls", "tofu-ls" })

-- Install Treesitter language
vim.list_extend(treesitter.ensure_installed, { "hcl" })

-- Setup conform
conform.opts.formatters_by_ft.terraform = { "opentofu" }
conform.opts.formatters_by_ft.tf = { "opentofu" }
conform.opts.formatters_by_ft.hcl = { "opentofu" }

-- conform.opts.formatters.terraform_fmt = function(bufnr)
--   local filename = vim.api.nvim_buf_get_name(bufnr)
--   return {
--     exe = "terraform",
--     args = { "fmt", filename },
--     stdin = false,
--     pre_hook = function()
--       if vim.bo[bufnr].modified then vim.api.nvim_buf_call(bufnr, function() vim.cmd "write" end) end
--     end,
--     post_hook = function()
--       if not vim.bo[bufnr].modified then
--         vim.api.nvim_buf_call(bufnr, function() vim.cmd "silent! checktime" end)
--       else
--         vim.notify("Buffer was modified after formatting; please save or reload manually", vim.log.levels.WARN)
--       end
--     end,
--   }
-- end
