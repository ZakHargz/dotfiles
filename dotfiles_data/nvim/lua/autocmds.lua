local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("BufWritePre", { pattern = "*", command = ":%s/\\s\\+$//e" }) -- Remove whitepsace on save
autocmd("BufEnter", { pattern = "*", command = "set fo-=c fo-=r fo-=o", }) -- Don't autocomment new lines
