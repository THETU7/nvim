local config = {}

function config.telescope()
  require('telescope').setup({
    defaults = {
      layout_config = {
        horizontal = { prompt_position = 'top', results_width = 0.6 },
        vertical = { mirror = false },
      },
      sorting_strategy = 'ascending',
      file_previewer = require('telescope.previewers').vim_buffer_cat.new,
      grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
      qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
    },
  })
  require('telescope').load_extension('fzy_native')
end

function config.toggleterm()
  require('toggleterm').setup({
    open_mapping = [[<c-\>]],
  })

  local Terminal = require('toggleterm.terminal').Terminal
  local lazygit = Terminal:new({ cmd = 'lazygit', hidden = true, direction = 'float' })

  function Lazygit_toggle()
    lazygit:toggle()
  end

  local wk = require('which-key')

  wk.register({
    ['<A-g>'] = { '<cmd>lua Lazygit_toggle() <CR>', 'lazygit' },
    ['<A-f>'] = { '<cmd>ToggleTerm direction=float <CR>', 'float-terminal' },
    ['<A-t>'] = { '<cmd>ToggleTerm direction=tab <CR>', 'tab-terminal' },
  })

  function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    -- vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  end

  -- if you only want these mappings for toggle term use term://*toggleterm#* instead
  vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
end

function config.cpptools(config_)
  config_.configurations = {
    {
      name = 'Launch file with formatString',
      type = 'cppdbg',
      request = 'launch',
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopAtEntry = true,
      setupCommands = {
        {
          text = '-enable-pretty-printing',
          description = 'enable pretty printing',
          ignoreFailures = false,
        },
      },
    },
  }
  require('mason-nvim-dap').default_setup(config_)
end

function config.surfer()
  require('syntax-tree-surfer').setup({})
  -- Syntax Tree Surfer
  local opts = { noremap = true, silent = true }

  -- Normal Mode Swapping:
  -- Swap The Master Node relative to the cursor with it's siblings, Dot Repeatable
  -- vim.keymap.set('n', 'vU', function()
  --   vim.opt.opfunc = 'v:lua.STSSwapUpNormal_Dot'
  --   return 'g@l'
  -- end, { silent = true, expr = true })
  -- vim.keymap.set('n', 'vD', function()
  --   vim.opt.opfunc = 'v:lua.STSSwapDownNormal_Dot'
  --   return 'g@l'
  -- end, { silent = true, expr = true })
  --
  -- -- Swap Current Node at the Cursor with it's siblings, Dot Repeatable
  -- vim.keymap.set('n', 'vd', function()
  --   vim.opt.opfunc = 'v:lua.STSSwapCurrentNodeNextNormal_Dot'
  --   return 'g@l'
  -- end, { silent = true, expr = true })
  -- vim.keymap.set('n', 'vu', function()
  --   vim.opt.opfunc = 'v:lua.STSSwapCurrentNodePrevNormal_Dot'
  --   return 'g@l'
  -- end, { silent = true, expr = true })

  --> If the mappings above don't work, use these instead (no dot repeatable)
  vim.keymap.set('n', 'vd', '<cmd>STSSwapCurrentNodeNextNormal<cr>', opts)
  vim.keymap.set('n', 'vu', '<cmd>STSSwapCurrentNodePrevNormal<cr>', opts)
  vim.keymap.set('n', 'vD', '<cmd>STSSwapDownNormal<cr>', opts)
  vim.keymap.set('n', 'vU', '<cmd>STSSwapUpNormal<cr>', opts)

  -- Visual Selection from Normal Mode
  vim.keymap.set('n', 'vx', '<cmd>STSSelectMasterNode<cr>', opts)
  vim.keymap.set('n', 'vn', '<cmd>STSSelectCurrentNode<cr>', opts)

  -- Select Nodes in Visual Mode
  vim.keymap.set('x', 'J', '<cmd>STSSelectNextSiblingNode<cr>', opts)
  vim.keymap.set('x', 'K', '<cmd>STSSelectPrevSiblingNode<cr>', opts)
  vim.keymap.set('x', 'H', '<cmd>STSSelectParentNode<cr>', opts)
  vim.keymap.set('x', 'L', '<cmd>STSSelectChildNode<cr>', opts)

  -- Swapping Nodes in Visual Mode
  vim.keymap.set('x', '<A-j>', '<cmd>STSSwapNextVisual<cr>', opts)
  vim.keymap.set('x', '<A-k>', '<cmd>STSSwapPrevVisual<cr>', opts)
end

return config
