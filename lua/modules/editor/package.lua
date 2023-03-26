local package = require('core.pack').package
local conf = require('modules.editor.config')

package({
  'nvim-treesitter/nvim-treesitter',
  -- event = { 'BufReadPre', 'BufNewFile' },
  event = { 'BufReadPost', 'BufNewFile' },
  run = ':TSUpdate',
  config = conf.nvim_treesitter,
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
})

package({
  'lukas-reineke/indent-blankline.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    require('indent_blankline').setup({})
  end,
})

package({
  'glepnir/lspsaga.nvim',
  event = 'BufRead',
  config = function()
    require('lspsaga').setup({})
  end,
})
