local on_attach = function(client, bufnr)
	vim.cmd("command! LspDef lua vim.lsp.buf.definition()")

	if client.server_capabilities.document_formatting then
		vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
	end
end

return on_attach
