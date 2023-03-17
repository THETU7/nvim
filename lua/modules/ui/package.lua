local package = require('core.pack').package
local conf = require('modules.ui.config')

-- package({ 'glepnir/zephyr-nvim', lazy = false, config = conf.zephyr })
package({
  'folke/tokyonight.nvim',
  lazy = false,
  config = function()
    require('tokyonight').setup({
      style = 'night',
      styles = {
        functions = { italic = true },
      },
    })
    vim.cmd([[colorscheme tokyonight]])
  end,
})

package({ 'glepnir/dashboard-nvim', event = 'VimEnter', config = conf.dashboard })

package({
  'nvim-tree/nvim-tree.lua',
  cmd = 'NvimTreeToggle',
  config = conf.nvim_tree,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
})

package({
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  config = function()
    require('lualine').setup({
      options = {
        theme = 'tokyonight',
      },
    })
  end,
})

package({
  'akinsho/nvim-bufferline.lua',
  event = 'VeryLazy',
  version = 'v3.*',
  config = conf.nvim_bufferline,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
})
