-- ================================================================================================
-- TITLE: snacks
-- ABOUT: A collection of QoL plugins for Neovim
-- LINKS:
--    > github : https://github.com/folke/snacks.nvim
-- ================================================================================================

local map = vim.keymap.set

vim.pack.add {
  { src = "https://github.com/folke/snacks.nvim" },
}

require("snacks").setup {
  bigfile = { enabled = true },
  explorer = { enabled = true },
  indent = { enabled = true },
  input = { enabled = true },
  notifier = {
    enabled = true,
    timeout = 3000,
    style = "compact",
  },
  picker = {
    enabled = true,
    exclude = { ".git", "node_modules", ".next" },
  },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
  styles = {
    notification = {
      wo = { wrap = true }, -- Wrap notifications
    },
  },
}

-- stylua: ignore start
map("n", "<leader>e", function() Snacks.explorer() end)
map("n", "<leader><leader>", function() Snacks.picker.files { layout = {preset = "vscode"} } end )
map("n", "<leader>/", function() Snacks.picker.grep() end)
-- Find
map("n", "<leader>b", function() Snacks.picker.buffers() end)
map("n", "<leader>fc", function() Snacks.picker.files { cwd = vim.fn.stdpath "config" } end)
map("n", "<leader>fg", function() Snacks.picker.git_files() end)
map("n", "<leader>fp", function() Snacks.picker.projects() end)
-- Other
map("n", "<c-/>", function() Snacks.terminal() end)
map("n", "<leader>lg", function() Snacks.lazygit() end)
map("n", "<leader>bd", function () Snacks.bufdelete() end)
