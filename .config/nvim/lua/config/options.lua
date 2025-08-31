vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--Basic Settings
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8
vim.opt.wrap = false
vim.opt.cmdheight = 1
vim.opt.spelllang = { "en" }

-- Tabbing / Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%1:%c:%m"

-- Search Settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Visual Settings
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.showmatch = true
vim.opt.matchtime = 2
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.showmode = false
vim.opt.pumheight = 10
vim.opt.pumblend = 10
vim.opt.winblend = 0
vim.opt.conceallevel = 0
vim.opt.concealcursor = ""
vim.opt.lazyredraw = false
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000
vim.opt.synmaxcol = 300

-- -- File Handling
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 0
vim.opt.autoread = true
vim.opt.autowrite = false
vim.opt.diffopt:append "vertical"
vim.opt.diffopt:append "algorithm:patience"
vim.opt.diffopt:append "linematch:60"

-- Set undo directory and ensure it exists
local undodir = "~/.local/share/nvim/undodir"
vim.opt.undodir = vim.fn.expand(undodir)
local undodir_path = vim.fn.expand(undodir)
if vim.fn.isdirectory(undodir_path) == 0 then vim.fn.mkdir(undodir_path, "p") end

-- Behaviour Settings
vim.opt.errorbells = false
vim.opt.backspace = "indent,eol,start"
vim.opt.autochdir = false
vim.opt.iskeyword:append "-"
vim.opt.path:append "**"
vim.opt.selection = "inclusive"
vim.opt.mouse = "a"
vim.opt.clipboard:append "unnamedplus"
vim.opt.modifiable = true
vim.opt.encoding = "UTF-8"
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignorecase = true

-- Cursor Settings
vim.opt.guicursor = {
  "n-v-c:block",
  "i-ci-ve:block",
  "r-cr:hor20",
  "o:hor50",
  "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
  "sm:block-blinkwait175-blinkoff150-blinkon175",
}

-- Split Behaviour
vim.opt.splitbelow = true
vim.opt.splitright = true

-- vim.opt.incsearch = true
-- vim.opt.backup = false
-- vim.opt.clipboard = "unnamedplus"
-- vim.opt.cmdheight = 1
-- vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- vim.opt.conceallevel = 0
-- vim.opt.fileencoding = "utf-8"
-- vim.opt.hlsearch = true
-- vim.opt.ignorecase = true
-- vim.opt.mouse = "a"
-- vim.opt.pumheight = 10
-- vim.opt.showmode = false
-- vim.opt.showtabline = 0
-- vim.opt.smartcase = true
-- vim.opt.smartindent = true
-- vim.opt.splitbelow = true
-- vim.opt.splitright = true
-- vim.opt.swapfile = false
-- vim.opt.termguicolors = true
-- vim.opt.timeoutlen = 1000
-- vim.opt.undofile = true
-- vim.opt.updatetime = 100
-- vim.opt.writebackup = false
-- vim.opt.expandtab = true
-- vim.opt.shiftwidth = 2
-- vim.opt.cursorline = false
-- vim.opt.number = true
-- vim.opt.breakindent = true
-- vim.opt.relativenumber = true
-- vim.opt.numberwidth = 2
-- vim.opt.signcolumn = "yes:1"
-- vim.opt.wrap = false
-- vim.opt.scrolloff = 8
-- vim.opt.sidescrolloff = 8
-- vim.opt.showcmd = false
-- vim.opt.ruler = false
-- vim.opt.guifont = "FiraCode Nerd Font:h12"
-- vim.opt.title = true
-- vim.opt.confirm = true
-- vim.opt.fillchars = { eob = " " }
-- vim.opt.winborder = "rounded"
-- vim.opt.winborder = "single"
--
-- vim.opt.guicursor = ""
-- vim.opt.tabstop = 2

vim.filetype.add {
  extension = {
    env = "dotenv",
  },
  filename = {
    [".env"] = "dotenv",
    ["env"] = "dotenv",
  },
  pattern = {
    ["[jt]sconfig.*.json"] = "jsonc",
    ["%.env%.[%w_.-]+"] = "dotenv",
  },
}

-- Setup options for Neovide
-- Install neovide: ❯ brew install --ignore-dependencies  neovide
if vim.g.neovide then
  vim.o.guifont = "FiraCode Nerd Font:h12"
  vim.g.neovide_hide_mouse_when_typing = false
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_input_macos_option_key_is_meta = "only_left"
  vim.g.neovide_input_ime = true
  vim.g.neovide_input_use_logo = true
  vim.g.neovide_show_border = false

  vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })
end
