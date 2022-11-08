local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Auto reloads when the packer file is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- Remove whitespace on save
autocmd("BufWritePre", { pattern = "*", command = ":%s/\\s\\+$//e" })

-- Don't autocomment new lines
autocmd("BufEnter", { pattern = "*", command = "set fo-=c fo-=r fo-=o" })

-- Autoclose NVIM if last widow open
autocmd("BufEnter", {
	nested = true,
	callback = function()
		if #vim.api.nvim_list_wins() == 2 and vim.api.nvim_buf_get_name(0):match("NeoTree") ~= nil then
			vim.cmd("quit")
		end
	end,
})

-- Set dockerfile as dockerfile
autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.dockerfile",
	command = "set ft=dockerfile",
	group = vim.api.nvim_create_augroup("Dockerfile", { clear = true }),
})

-- Disable diagnostics in node_modules (0 is current buffer only)
vim.api.nvim_create_autocmd("BufRead", { pattern = "*/node_modules/*", command = "lua vim.diagnostic.disable(0)" })
vim.api.nvim_create_autocmd("BufNewFile", { pattern = "*/node_modules/*", command = "lua vim.diagnostic.disable(0)" })
