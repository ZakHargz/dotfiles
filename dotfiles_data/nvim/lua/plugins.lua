local paths = require('paths')

local packer_bootstrap = false
if vim.fn.empty(vim.fn.glob(paths.plugin_install_path)) > 0 then
  packer_bootstrap = vim.fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim',
    paths.plugin_install_path })
  vim.cmd.packadd('packer.nvim')
end

local packer = require('packer')
packer.init({ compile_path = paths.join(vim.fn.stdpath('data'),
  'site/pack/loader/start/packer.nvim/lua/packer_compiled.lua') })

packer.startup({
  function(use)
    -- Impatient has to be loaded before anything else.
    use('lewis6991/impatient.nvim')

    -- Packer can manage itself.
    use('wbthomason/packer.nvim')

    -- Dependencies required by other plugins
    use('nvim-lua/plenary.nvim')
    use('kyazdani42/nvim-web-devicons')

    -- LSP + Completion + Syntax
    use({ 'williamboman/mason.nvim', config = function() require('mason').setup() end })
    use({ 'neovim/nvim-lspconfig', requires = { 'j-hui/fidget.nvim', 'rmagatti/goto-preview' } })
    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
    use({ 'hrsh7th/nvim-cmp',
      requires = { 'onsails/lspkind-nvim', 'saadparwaiz1/cmp_luasnip', 'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp-signature-help', 'hrsh7th/cmp-cmdline', { 'hrsh7th/cmp-nvim-lua', ft = 'lua' },
        'L3MON4D3/LuaSnip' }, event = { 'InsertEnter' }, keys = { { 'v', ':' }, { 'n', ':' } }, module = 'cmp' })

    -- UI + Other Utils
    use({ 'catppuccin/nvim', as = 'catppuccin' })
    use({ 'nvim-telescope/telescope.nvim', requires = { 'nvim-telescope/telescope-file-browser.nvim' } })
    use('lewis6991/gitsigns.nvim')
    use('kyazdani42/nvim-tree.lua')
    use('akinsho/nvim-bufferline.lua')
    use('nvim-lualine/lualine.nvim')
    use({ 'junegunn/fzf.vim', requires = { 'junegunn/fzf' } })

  end,
  config = {
    profile = {
      enable = true,
      threshold = 1,
    },
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end,
    },
  },
});

if packer_bootstrap then
  packer.sync()
end

pcall(require, 'packer_compiled')
