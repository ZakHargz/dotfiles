local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
	return
end

-- Recommended by nvim-tree documentation
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

nvimtree.setup({
	git = {
		enable = true,
	},
	view = {
		float = {
			enable = true,
			open_win_config = {
				relative = "cursor",
				border = "rounded",
				row = 1,
				col = 1,
			},
		},
	},
})
