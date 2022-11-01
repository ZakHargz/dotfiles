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

	if client.name ~= "null-ls" and client.name ~= "sumneko_lua" then
		vim.api.nvim_create_autocmd({ "BufWritePre" }, {
			pattern = "<buffer>",
			callback = function()
				if vim.lsp.buf.server_ready() then
					OrganiseImports(150)
				end
			end,
			group = vim.api.nvim_create_augroup("LSPOrganizeImports", { clear = true }),
		})
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
				library = vim.api.nvim_get_runtime_file("", true),
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

lspconfig["jsonls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["tailwindcss"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

function OrganiseImports(timeoutms)
	local clients = vim.lsp.buf_get_clients()
	for _, client in pairs(clients) do
		local params = vim.lsp.util.make_range_params(nil, client.offset_encoding)
		params.context = { only = { "source.organiseImports" } }

		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeoutms)
		for _, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					vim.lsp.util.apply_workout_edit(r.edit, client.offset_encoding)
				else
					vim.lsp.buf.execute_command()
				end
			end
		end
	end
end
