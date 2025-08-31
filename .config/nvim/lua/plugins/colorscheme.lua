vim.pack.add {
  { src = "https://github.com/catppuccin/nvim" },
  { src = "https://github.com/rose-pine/neovim" },
  { src = "https://github.com/marko-cerovac/material.nvim" },
}

require("rose-pine").setup {
  variant = "moon", -- auto, main, moon, or dawn
  dark_variant = "main", -- main, moon, or dawn
  dim_inactive_windows = false,
  extend_background_behind_borders = true,

  enable = {
    terminal = true,
    legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
    migrations = true, -- Handle deprecated options automatically
  },

  styles = {
    bold = true,
    italic = true,
    transparency = false,
  },

  groups = {
    border = "muted",
    link = "iris",
    panel = "surface",

    error = "love",
    hint = "iris",
    info = "foam",
    note = "pine",
    todo = "rose",
    warn = "gold",

    git_add = "foam",
    git_change = "rose",
    git_delete = "love",
    git_dirty = "rose",
    git_ignore = "muted",
    git_merge = "iris",
    git_rename = "pine",
    git_stage = "iris",
    git_text = "rose",
    git_untracked = "subtle",

    h1 = "iris",
    h2 = "foam",
    h3 = "rose",
    h4 = "gold",
    h5 = "pine",
    h6 = "foam",
  },

  palette = {},
  highlight_groups = {},
  before_highlight = function(group, highlight, palette) end,
}

require("catppuccin").setup {
  float = {
    transparent = false,
    solid = false,
  },
  integrations = {
    dropbar = true,
    treesitter = true,
    snacks = true,
  },
}

vim.cmd "colorscheme catppuccin-mocha"
-- vim.cmd("colorscheme rose-pine-moon")
-- vim.cmd("colorscheme rose-pine-dawn")
