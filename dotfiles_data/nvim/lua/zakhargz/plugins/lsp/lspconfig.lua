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
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

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

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

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
	flags = {
		debounce_text_changes = 150,
	},
})

lspconfig["jsonls"].setup({
	capabilities = capabilities,
	on_attach = on_attach.on_attach,
	settings = {
		json = {
			schemas = {
				{ fileMatch = { "jsconfig.json" }, url = "https://json.schemastore.org/jsconfig" },
				{ fileMatch = { "tsconfig.json" }, url = "https://json.schemastore.org/tsconfig" },
				{ fileMatch = { "package.json" }, url = "https://json.schemastore.org/package" },
			},
		},
	},
})

lspconfig["tailwindcss"].setup({
	capabilities = capabilities,
	on_attach = on_attach.on_attach,
})

-- lspconfig["yamlls"].setup({
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	settings = {
-- 		yaml = {
-- 			schemas = {
-- 				["http://json.schemastore.org/gitlab-ci"] = ".gitlab-ci.yml",
-- 				["http://json.schemastore.org/composer"] = "composer.yaml",
-- 				["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.yml",
-- 				["https://raw.githubusercontent.com/kamilkisiela/graphql-config/v3.0.3/config-schema.json"] = ".graphqlrc*",
-- 			},
-- 		},
-- 	},
-- })
