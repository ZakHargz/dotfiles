local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

treesitter.setup({
	highlight = {
		enable = true,
	},
	ident = { enable = true },
	autotag = { enable = true },
	ensure_installed = {
		"json",
		"javascript",
		"typescript",
		"tsx",
		"yaml",
		"bash",
		"lua",
		"vim",
		"dockerfile",
		"gitignore",
		"fish",
	},
	auto_install = true,
	autopairs = { enable = true },
})
