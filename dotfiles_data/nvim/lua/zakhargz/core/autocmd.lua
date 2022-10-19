local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Auto reloads when the packer file is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

autocmd("BufWritePre", { pattern = "*", command = ":%s/\\s\\+$//e" }) -- Remove whitepsace on save
autocmd("BufEnter", { pattern = "*", command = "set fo-=c fo-=r fo-=o" }) -- Don't autocomment new lines
