local keymap = require('core.keymap')
local nmap, imap, cmap, xmap, vmap = keymap.nmap, keymap.imap, keymap.cmap, keymap.xmap, keymap.vmap
local silent, noremap = keymap.silent, keymap.noremap
local opts = keymap.new_opts
local cmd = keymap.cmd

-- Use space as leader key
vim.g.mapleader = ' '

-- leaderkey
nmap({ ' ', '', opts(noremap) })
xmap({ ' ', '', opts(noremap) })

-- usage example
nmap({
  -- noremal remap
  -- close buffer
  { '<C-x>k', cmd('bdelete'), opts(noremap, silent) },
  -- select all
  { '<C-a>', 'ggVG', opts(noremap, silent) },
  -- save
  { '<C-s>', cmd('write'), opts(noremap) },
  -- yank
  { 'Y', 'y$', opts(noremap) },
  -- buffer jump
  { ']b', cmd('bn'), opts(noremap) },
  { '[b', cmd('bp'), opts(noremap) },
  -- remove trailing white space
  { '<Leader>t', cmd('TrimTrailingWhitespace'), opts(noremap) },
  -- window jump
  { 'sh', '<C-w>h', opts(noremap) },
  { 'sl', '<C-w>l', opts(noremap) },
  { 'sj', '<C-w>j', opts(noremap) },
  { 'sk', '<C-w>k', opts(noremap) },
  -- slipt
  { 'ss', cmd('split'), opts(noremap) },
  { 'sv', cmd('vsplit'), opts(noremap) },
})

imap({
  -- insert mode
  { '<C-h>', '<Bs>', opts(noremap) },
  { '<C-e>', '<End>', opts(noremap) },
  -- save
  { '<C-s>', '<Esc><cmd>write<cr>', opts(noremap) },
  -- luasnip
  { '<C-j>', cmd("lua require'luasnip'.jump(1)"), opts(silent) },
  { '<C-p>', cmd("lua require'luasnip'.jump(-1)"), opts(silent) },
})

-- commandline remap
cmap({ '<C-b>', '<Left>', opts(noremap) })
-- usage of plugins
nmap({
  -- plugin manager: Lazy.nvim
  { '<Leader>pu', cmd('Lazy update'), opts(noremap, silent) },
  { '<Leader>pi', cmd('Lazy install'), opts(noremap, silent) },
  -- dashboard
  { '<Leader>n', cmd('DashboardNewFile'), opts(noremap, silent) },
  { '<Leader>ss', cmd('SessionSave'), opts(noremap, silent) },
  { '<Leader>sl', cmd('SessionLoad'), opts(noremap, silent) },
  -- nvimtree
  { '<C-f>', cmd('NvimTreeToggle'), opts(noremap, silent) },
  -- Telescope
  { '<Leader>fb', cmd('Telescope buffers'), opts(noremap, silent) },
  { '<Leader>fg', cmd('Telescope live_grep'), opts(noremap, silent) },
  { '<Leader>ff', cmd('Telescope find_files'), opts(noremap, silent) },
  -- bufferline
  { '<Leader>1', cmd('BufferLineGoToBuffer 1'), opts(silent) },
  { '<Leader>2', cmd('BufferLineGoToBuffer 2'), opts(silent) },
  { '<Leader>3', cmd('BufferLineGoToBuffer 3'), opts(silent) },
  { '<Leader>4', cmd('BufferLineGoToBuffer 4'), opts(silent) },
  { '<Leader>5', cmd('BufferLineGoToBuffer 5'), opts(silent) },
  { '<Leader>6', cmd('BufferLineGoToBuffer 6'), opts(silent) },
  { '<Leader>7', cmd('BufferLineGoToBuffer 7'), opts(silent) },
  { '<Leader>8', cmd('BufferLineGoToBuffer 8'), opts(silent) },
  { '<Leader>9', cmd('BufferLineGoToBuffer 9'), opts(silent) },
  -- tab缩进
  { '<tab>', 'V>', opts(noremap) },
  { '<s-tab>', 'V<', opts(noremap) },
  -- trouble
  { '<leader>xx', cmd('TroubleToggle'), opts(noremap, silent) },
  -- hop 移动
  { 'fl', cmd('HopLineStart'), opts(noremap, silent) },
  { 'fw', cmd('HopWord'), opts(noremap, silent) },
  -- neogen 生成函数、类注释
  { '<leader>cc', cmd('Neogen'), opts(noremap, silent) },
})

vmap({
  -- tab缩进
  { '<tab>', '>gv', opts(noremap) },
  { '<s-tab>', '<gv', opts(noremap) },
})

require('keymap.lspsaga_config')

vim.keymap.set('n', '<F5>', function()
  require('dap').continue()
end)
vim.keymap.set('n', '<F10>', function()
  require('dap').step_over()
end)
vim.keymap.set('n', '<F11>', function()
  require('dap').step_into()
end)
vim.keymap.set('n', '<F12>', function()
  require('dap').step_out()
end)

vim.keymap.set('n', '<F9>', function()
  require('dap').toggle_breakpoint()
end)

vim.keymap.set('n', '<Leader>dr', function()
  require('dap').repl.open()
end)
vim.keymap.set('n', '<Leader>dl', function()
  require('dap').run_last()
end)
