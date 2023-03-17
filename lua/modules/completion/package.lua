local package = require('core.pack').package
local conf = require('modules.completion.config')

-- @info mason.nvim is optimized to load as little as possible during setup.
-- Lazy-loading the plugin, or somehow deferring the setup, is not recommended.
package({
  'neovim/nvim-lspconfig',
  config = function()
    require('modules.completion.lspconfig')
  end,
  event = { 'BufReadPre', 'BufNewFile' },
  -- event = { 'BufReadPost', 'BufNewFile' },
  dependencies = {
    {
      'williamboman/mason.nvim',
      config = conf.mason,
    },
    { 'williamboman/mason-lspconfig.nvim', config = conf.mason_lspconfig },
    { 'jay-babu/mason-null-ls.nvim', config = conf.mason_nullls },
    {
      'jose-elias-alvarez/null-ls.nvim',
      config = function()
        require('modules.completion.null_ls_config')
      end,
    },
  },
  -- lazy = true,
  -- event = "VeryLazy",
})

package({
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  config = conf.nvim_cmp,
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-buffer' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'onsails/lspkind-nvim' },
    { 'windwp/nvim-autopairs', config = conf.auto_pairs },
    { 'hrsh7th/cmp-nvim-lsp-signature-help' },
  },
})

package({
  'L3MON4D3/LuaSnip',
  event = 'InsertCharPre',
  config = conf.lua_snip,
  dependencies = { 'rafamadriz/friendly-snippets' },
})

package({
  'windwp/nvim-ts-autotag',
  -- event = 'InsertEnter',
  ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  config = function()
    require('nvim-treesitter.configs').setup({
      autotag = {
        enable = true,
      },
    })
  end,
  --[[ dependencies = {
    { 'nvim-treesitter' },
  }, ]]
})
