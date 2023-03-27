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
  event = { 'BufRead', 'BufNewFile' },
  version = 'v3.*',
  config = conf.nvim_bufferline,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
})

package({
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        -- ['cmp.entry.get_documentation'] = true,
      },
    },
    presets = {
      bottom_search = true,
      command_palette = false,
      long_message_to_split = true,
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
    },
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
})
