local package = require('core.pack').package
local conf = require('modules.tools.config')

package({
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  config = conf.telescope,
  dependencies = {
    { 'nvim-lua/plenary.nvim', lazy = true },
    { 'nvim-telescope/telescope-fzy-native.nvim' },
  },
})

package({
  'glepnir/hlsearch.nvim',
  event = 'BufRead',
  config = function()
    require('hlsearch').setup()
  end,
})

package({
  'numToStr/Comment.nvim',
  -- keys = { 'gcc', 'gcb', 'gc', 'gb' }, -- 当在视图模式下无效
  config = function()
    require('Comment').setup({
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    })
  end,
  event = 'VeryLazy',
  dependencies = {
    {
      'JoosepAlviste/nvim-ts-context-commentstring',
      config = function()
        require('nvim-treesitter.configs').setup({
          context_commentstring = {
            enable = true,
            enable_autocmd = false,
          },
        })
      end,
    },
  },
})

package({
  'folke/trouble.nvim',
  cmd = 'TroubleToggle',
  config = function()
    require('trouble').setup({})
  end,
})

package({
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  -- event = "VeryLazy",
  config = function()
    require('gitsigns').setup()
  end,
})

package({
  'rmagatti/auto-session',
  event = 'VimEnter',
  config = function()
    require('auto-session').setup({
      log_level = 'error',
      auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
    })
  end,
})

package({
  'phaazon/hop.nvim',
  cmd = { 'HopWord', 'HopLineStart' },
  branch = 'v2', -- optional but strongly recommended
  config = function()
    require('hop').setup({})
  end,
})

package({
  'danymat/neogen',
  cmd = 'Neogen',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  config = function()
    require('neogen').setup({
      snippet_engine = 'luasnip',
    })
  end,
  -- Uncomment next line if you want to follow only stable versions
  -- version = "*"
})

package({
  'folke/which-key.nvim',
  event = 'VeryLazy',
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    require('which-key').setup({})
  end,
})

package({
  'akinsho/toggleterm.nvim',
  keys = { [[<C-\>]], '<A-g>', '<A-f>', '<A-t>' },
  version = '*',
  config = conf.toggleterm,
})

package({ 'ellisonleao/glow.nvim', config = true, cmd = 'Glow' })

package({
  'iamcco/markdown-preview.nvim',
  build = 'cd app && npm install',
  config = function()
    vim.g.mkdp_filetypes = { 'markdown' }
  end,
  ft = { 'markdown' },
})

package({
  'rcarriga/nvim-dap-ui',
  config = function()
    local dap, dapui = require('dap'), require('dapui')
    dapui.setup()
    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end
  end,
  --keys = { '<F5>', '<F9>', '<F10>', '<F11>', '<F12>' },
  ft = { 'c', 'cpp' },
  dependencies = {
    { 'mfussenegger/nvim-dap' },
    {
      'jay-babu/mason-nvim-dap.nvim',
      config = function()
        local install = require('modules.tools.dap_install')
        require('mason').setup()
        require('mason-nvim-dap').setup({
          ensure_installed = install,
          automatic_setup = true,
        })
        require('mason-nvim-dap').setup_handlers({})
      end,
    },
    { 'williamboman/mason.nvim' },
  },
})
