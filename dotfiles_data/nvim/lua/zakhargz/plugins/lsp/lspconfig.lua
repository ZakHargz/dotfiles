local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

local typescript_setup, typescript = pcall(require, "typescript")
if not typescript_setup then
	return
end

local on_attach = function(client)
	if not init_done then
		init_done = true
		require("fidget").setup({
			text = {
				spinner = "arc",
			},
		})
	end

	if client.name == "tsserver" then
		vim.keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>")
	end
end

-- Enable autocomplete
local capabilities = require("cmp_nvim_lsp").default_capabilities()

typescript.setup({
	server = {
		capabilities = capabilities,
		on_attach = on_attach,
	},
})

lspconfig["sumneko_lua"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

lspconfig["gopls"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	cmd = { "gopls" },
})

lspconfig["dockerls"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "dockerfile" },
	cmd = { "docker-langserver", "--stdio" },
})

lspconfig["bashls"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "sh" },
	cmd = { "bash-language-server", "start" },
	command_env = { GLOB_PATTERN = "*@(.sh|.inc|.bash|.command)" },
})

lspconfig["terraformls"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "terraform", "hcl", "tf" },
	cmd = { "terraform-lsp" },
})
