vim.g.mapleader = ' '
vim.opt.compatible = false
vim.opt.cursorline = false
vim.opt.autoread = true
vim.opt.mouse = 'a'
vim.opt.autoindent = true
vim.opt.backspace = 'indent,eol,start'
vim.opt.scrolloff = 4
vim.opt.hidden = true
vim.opt.number = true
vim.opt.undodir = vim.env.HOME .. '/.vim/undodir'
vim.opt.undofile = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.wildmenu = true
vim.opt.wrap = false
vim.opt.autochdir = false
vim.opt.diffopt = 'vertical'
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.termguicolors = true
vim.opt.syntax = 'on'
vim.opt.modeline = true
vim.opt.updatetime = 100
vim.opt.confirm = true
vim.opt.showtabline = 0
vim.opt.sessionoptions = 'buffers,curdir,folds,winpos,winsize,localoptions'
vim.opt.laststatus = 3

-- setting to 0 makes it default to value of tabstop
vim.opt.shiftwidth = 0
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.shortmess:append('I')
vim.opt.wildignore:append({ '*.DS_Store' })
vim.opt.whichwrap:append({ ['<'] = true, ['>'] = true, ['h'] = true, ['l'] = true, ['['] = true, [']'] = true })
vim.opt.iskeyword:append({ '@-@', '-', '$' })

vim.opt.fillchars = {
  horiz = '━',
  horizup = '┻',
  horizdown = '┳',
  vert = '┃',
  vertleft = '┫',
  vertright = '┣',
  verthoriz = '╋',
}

local disabled_built_ins = {
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  'gzip',
  'zip',
  'zipPlugin',
  'tar',
  'tarPlugin',
  'getscript',
  'getscriptPlugin',
  'vimball',
  'vimballPlugin',
  '2html_plugin',
  'logipat',
  'rrhelper',
  'spellfile_plugin',
  'matchit',
}

vim.tbl_map(function(plugin)
  vim.g['loaded_' .. plugin] = 1
end, disabled_built_ins)

vim.cmd([[set iskeyword+=-]])
vim.cmd("set wildignore+=*/vendor/**")
vim.cmd("set wildignore+=*/node_modules/**")

vim.api.nvim_create_user_command("RemoveDocBlock", [[%s,/\*\_.\{-}\*/,,g]], {})
