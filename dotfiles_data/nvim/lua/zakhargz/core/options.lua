local opt = vim.opt

-- Language locations
vim.g.python3_host_prog = "/opt/homebrew/bin/python3"
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- General Options
opt.relativenumber = false
opt.cmdheight = 0
opt.number = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.cindent = true
opt.expandtab = true
opt.wrap = false
opt.ignorecase = true
opt.smartcase = true
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.backspace = "indent,eol,start"
opt.clipboard:append("unnamedplus")
opt.splitright = true
opt.splitbelow = true
vim.opt.shortmess:append("I")
vim.opt.wildignore:append({ "*.DS_Store" })
vim.opt.whichwrap:append({ ["<"] = true, [">"] = true, ["h"] = true, ["l"] = true, ["["] = true, ["]"] = true })
vim.opt.iskeyword:append({ "@-@", "-", "$" })
vim.opt.mouse = "a"
vim.opt.undofile = true

vim.opt.fillchars = {
	horiz = "━",
	horizup = "┻",
	horizdown = "┳",
	vert = "┃",
	vertleft = "┫",
	vertright = "┣",
	verthoriz = "╋",
}

local disabled_built_ins = {
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"logipat",
	"rrhelper",
	"spellfile_plugin",
	"matchit",
}

vim.tbl_map(function(plugin)
	vim.g["loaded_" .. plugin] = 1
end, disabled_built_ins)

vim.cmd([[set iskeyword+=-]])
vim.cmd("set wildignore+=*/vendor/**")
vim.cmd("set wildignore+=*/node_modules/**")

vim.api.nvim_create_user_command("RemoveDocBlock", [[%s,/\*\_.\{-}\*/,,g]], {})

-- Create Undo directory if it doesn't exist.
local undodir = "/tmp/.vim-undodir-" .. vim.env.USER
if vim.fn.isdirectory(undodir) ~= 1 then
	vim.fn.mkdir(undodir, "p", "0700")
end
