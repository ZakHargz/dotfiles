return {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yml", "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.helm-values" },
  root_markers = { ".git" },
  settings = {
    redhat = { telemetry = { enabled = false } },
  },
}
