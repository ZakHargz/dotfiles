vim.pack.add {
  { src = "https://github.com/folke/lazydev.nvim" },
  { src = "https://github.com/windwp/nvim-ts-autotag" },
  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/stevearc/dressing.nvim" },
  { src = "https://github.com/echasnovski/mini.icons" },
  { src = "https://github.com/fladson/vim-kitty" },
}

-- Lazydev
require("lazydev").setup {
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
}

-- nvim-auto-tag
require("nvim-ts-autotag").setup()

-- nvim-autopairs
require("nvim-autopairs").setup {
  check_ts = true,
}

-- dressing
require("dressing").setup()

-- mini.icons
require("mini.icons").setup()
