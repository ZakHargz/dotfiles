local blink = require "blink.cmp"

return {
  name = "terraform-ls",
  cmd = { "terraform-ls", "serve" },
  filetypes = { "terraform", "tf", "hcl", "tfvars" },
  root_markers = { ".terraform", ".git", "*.tf" },
  settings = {
    terraform = {
      ignoreSingleFileWarning = true,
    },
  },
  capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    blink.get_lsp_capabilities()
  ),
}
