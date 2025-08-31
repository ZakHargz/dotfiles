vim.pack.add {
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
}

local M = {}

M.ensure_installed = {}

M.setup = function()
  require("nvim-treesitter.configs").setup {
    sync_install = false,
    modules = {},
    ignore_install = {},
    indent = { enable = true },
    auto_install = false,
    ensure_installed = vim.tbl_extend("force", { "bash", "query", "regex", "vim", "vimdoc" }, M.ensure_installed),
    highlight = { enable = true, additional_vim_regex_highlighting = false },
  }
end

return M
