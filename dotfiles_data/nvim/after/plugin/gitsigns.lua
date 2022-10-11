require('gitsigns').setup({
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol',
    delay = 100,
  },
  worktrees = {
    {
      toplevel = vim.env.HOME,
      gitdir = string.format('%s/.dotfiles', vim.env.HOME),
    },
  },
})
