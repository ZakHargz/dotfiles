local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

local on_attach_status, on_attach = pcall(require, "zakhargz.plugins.lsp.on_attach")
if not on_attach_status then
	vim.notify("require('plugins.lsp.on_attach') failed")
end

-- Enable autocomplete
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.diagnostic.config({
	severity_sort = true,
	virtual_text = true,
	underline = true,
	signs = true,
	update_in_insert = false,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

lspconfig["tsserver"].setup({
	capabilities = capabilities,
	on_attach = on_attach.on_attach,
	filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
	cmd = { "typescript-language-server", "--stdio" },
})

lspconfig["sumneko_lua"].setup({
	capabilities = capabilities,
	on_attach = on_attach.on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
})

lspconfig["gopls"].setup({
	on_attach = on_attach.on_attach,
	capabilities = capabilities,
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	cmd = { "gopls" },
})

lspconfig["dockerls"].setup({
	on_attach = on_attach.on_attach,
	capabilities = capabilities,
	filetypes = { "dockerfile" },
	cmd = { "docker-langserver", "--stdio" },
})

lspconfig["bashls"].setup({
	on_attach = on_attach.on_attach,
	capabilities = capabilities,
	filetypes = { "sh" },
	cmd = { "bash-language-server", "start" },
	command_env = { GLOB_PATTERN = "*@(.sh|.inc|.bash|.command)" },
})

lspconfig["terraformls"].setup({
	on_attach = on_attach.on_attach,
	capabilities = capabilities,
	filetypes = { "terraform", "hcl", "tf" },
	cmd = { "terraform-lsp" },
})

lspconfig["jsonls"].setup({
	capabilities = capabilities,
	on_attach = on_attach.on_attach,
})

lspconfig["tailwindcss"].setup({
	capabilities = capabilities,
	on_attach = on_attach.on_attach,
})

-- function OrganiseImports(timeoutms)
-- 	local clients = vim.lsp.buf_get_clients()
-- 	for _, client in pairs(clients) do
-- 		local params = vim.lsp.util.make_range_params(nil, client.offset_encoding)
-- 		params.context = { only = { "source.organiseImports" } }
--
-- 		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeoutms)
-- 		for _, res in pairs(result or {}) do
-- 			for _, r in pairs(res.result or {}) do
-- 				if r.edit then
-- 					vim.lsp.util.apply_workout_edit(r.edit, client.offset_encoding)
-- 				else
-- 					vim.lsp.buf.execute_command()
-- 				end
-- 			end
-- 		end
-- 	end
-- end
