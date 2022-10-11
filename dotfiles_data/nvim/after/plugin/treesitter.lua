local status, ts = pcall(require, 'nvim-treesitter.configs')
if (not status) then return end

ts.setup {
  highlight = { enable = true },
  indent = { enable = true },
  ensure_installed = { 'fish', 'tsx', 'lua', 'json', 'go', 'bash', 'dockerfile', 'hcl', 'javascript', 'typescript',
    'yaml' },
  autotag = { enable = true }
}
