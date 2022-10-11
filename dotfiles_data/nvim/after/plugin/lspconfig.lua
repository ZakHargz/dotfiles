local status, nvim_lsp = pcall(require, 'lspconfig')
if (not status) then return end

local protocol = require('vim.lsp.protocol')
local init_done = false

local on_attach = function(client, bufnr)
  if not init_done then
    init_done = true
    require('fidget').setup({
      text = {
        spinner = 'arc'
      },
    })
    require('goto-preview').setup({
      height = 15,
      width = 120,
      default_mappings = true,
      border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' }
    })
  end

  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
    vim.api.nvim_command [[augroup END]]
  end
end

nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" }
}

nvim_lsp.dockerls.setup {
  on_attach = on_attach,
  filetypes = { "dockerfile" },
  cmd = { "docker-langserver", "--stdio" },
}

nvim_lsp.gopls.setup {
  on_attach = on_attach,
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  cmd = { "gopls" }
}

nvim_lsp.bashls.setup {
  on_attach = on_attach,
  filetypes = { "sh" },
  cmd = { "bash-language-server", "start" },
  command_env = { GLOB_PATTERN = "*@(.sh|.inc|.bash|.command)" }
}

nvim_lsp.terraform_lsp.setup {
  on_attach = on_attach,
  filetypes = { "terraform", "hcl", "tf" },
  cmd = { "terraform-lsp" }
}

nvim_lsp.terraformls.setup {
  on_attach = on_attach,
  filetypes = { "terraform" },
  cmd = { "terraform-ls", "serve" }
}

nvim_lsp.sumneko_lua.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true)
      }
    }
  }
}
