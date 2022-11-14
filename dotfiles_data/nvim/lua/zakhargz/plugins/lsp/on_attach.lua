local navic = require("nvim-navic")
local opts = { noremap = true, silent = true }

local M = {}

M.on_attach = function(client, bufnr)
	local capabilities = client.server_capabilities

	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gh", ":lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":lua vim.lsp.buf.rename()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gf", ":lua vim.lsp.buf.formatting()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":lua vim.lsp.buf.implementation()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "ca", ":lua vim.lsp.buf.code_action()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>de", ":lua vim.diagnostic.open_float()<CR>", opts)

	capabilities.document_formatting = false

	if capabilities.document_highlighting then
		vim.cmd([[
      highlight! link LspReferenceText Visual
      highlight! link LspReferenceRead Visual
      highlight! link LspReferenceWrite Visual

      augroup LspDocumentHighlight
        autocmd! * <buffer>
        autocmd! CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd! CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup end
    ]])
	end

	if capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end

	require("fidget").setup({
		text = {
			spinner = "arc",
		},
	})
end

return M
