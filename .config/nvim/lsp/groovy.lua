---@type vim.lsp.Config
return {
  cmd = {
    "java",
    "-jar",
    "/Users/hargrzak/.local/share/nvim/mason/packages/groovy-language-server/build/libs/groovy-language-server-all.jar",
  },
  filetypes = { "groovy" },
  root_markers = { "Jenkinsfile", ".git" },
}
