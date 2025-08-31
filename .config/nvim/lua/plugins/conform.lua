vim.pack.add {
  { src = "https://github.com/stevearc/conform.nvim" }
}

-- formatexpr
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

local M = {}

M.opts = {
  formatters_by_ft = {},
  formatters = {},
  default_format_opts = { lsp_fallback = true },
  format_on_save = {
    timeout_ms = 1000,
    lsp_fallback = true
  }
}

function M.setup()
  require 'conform'.setup(M.opts)

  vim.keymap.set({ "n", "v" }, "<leader>cf", function()
    require("conform").format({ async = true }, function(err, did_edit)
      if not err and did_edit then
        vim.notify("Code formatted", vim.log.levels.INFO, { title = "Conform" })
      end
    end)
  end, { desc = "Format buffer" })
end

return M
