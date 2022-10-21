local opt = vim.opt

-- General Options
opt.relativenumber = false
opt.number = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
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