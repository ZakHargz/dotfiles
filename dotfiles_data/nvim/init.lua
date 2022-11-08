local present, impatient = pcall(require, "impatient")
if present then
	impatient.enable_profile()
end

-- Plugins
require("zakhargz.plugins-setup")

-- Core setup
require("zakhargz.core.options")
require("zakhargz.core.keymaps")
require("zakhargz.core.colorscheme")
require("zakhargz.core.autocmd")

-- Plugins
require("zakhargz.plugins.nvim-cmp")
require("zakhargz.plugins.comment")
require("zakhargz.plugins.neo-tree")
require("zakhargz.plugins.telescope")
require("zakhargz.plugins.autopairs")
require("zakhargz.plugins.treesitter")
require("zakhargz.plugins.gitsigns")
require("zakhargz.plugins.bufferline")
require("zakhargz.plugins.neo-term")
require("zakhargz.plugins.trouble")
require("zakhargz.plugins.lualine.lualine")
require("zakhargz.plugins.nvim-navic")
require("zakhargz.plugins.mini")

-- LSP Plugins
require("zakhargz.plugins.lsp.mason")
require("zakhargz.plugins.lsp.lspsaga")
require("zakhargz.plugins.lsp.lspconfig")
require("zakhargz.plugins.lsp.null-ls")
