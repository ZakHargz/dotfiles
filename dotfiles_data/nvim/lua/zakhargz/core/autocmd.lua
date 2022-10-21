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
autocmd("BufEnter", {
	nested = true,
	callback = function()
		if #vim.api.nvim_list_wins() == 2 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
			vim.cmd("quit")
		end
	end,
}) -- Autoclose NVIM if last window open

autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.dockerfile",
	command = "set ft=dockerfile",
	group = vim.api.nvim_create_augroup("Dockerfile", { clear = true }),
}) -- Set dockerfile as dockerfile
