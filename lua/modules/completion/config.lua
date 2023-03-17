local config = {}
local lspInstall = require('modules.completion.install')

-- cmp config
function config.nvim_cmp()
  local cmp = require('cmp')

  -- 格式化
  local cmpFormat = function(entry, vim_item)
    -- fancy icons and a name of kind
    vim_item.kind = require('lspkind').presets.default[vim_item.kind] .. ''
    -- set a name for each source
    vim_item.menu = ({
      buffer = '[Buffer]',
      nvim_lsp = '[LSP]',
      -- ultisnips = "[UltiSnips]",
      luasnip = '[LuaSnip]',
      path = '[Path]',
      spell = '[Spell]',
    })[entry.source.name]
    return vim_item
  end

  cmp.setup({
    formatting = { format = cmpFormat },
    preselect = cmp.PreselectMode.Item,
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    snippet = {
      expand = function(args)
        -- vim.fn["UltiSnips#Anon"](args.body)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'path' },
      { name = 'buffer', keyword_length = 5 },
    }),
  })

  --[[ -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' },
    }, {
      { name = 'cmdline' },
    }),
  }) ]]

  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' },
    },
  })
end

function config.auto_pairs()
  local cmp = require('cmp')
  require('nvim-autopairs').setup({})
  -- 括号
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
end

function config.mason()
  local mason = require('mason')

  mason.setup()
end

function config.mason_nullls()
  require('mason-null-ls').setup({
    ensure_installed = lspInstall.null_install,
    automatic_installation = false,
    automatic_setup = true, -- Recommended, but optional
  })

  require('mason-null-ls').setup_handlers({})
end

function config.mason_lspconfig()
  local mason_lsp = require('mason-lspconfig')

  mason_lsp.setup({
    ensure_installed = lspInstall.lsp_install,
  })
end

function config.lua_snip()
  local ls = require('luasnip')
  local types = require('luasnip.util.types')
  ls.config.set_config({
    history = true,
    enable_autosnippets = true,
    updateevents = 'TextChanged,TextChangedI',
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { '<- choiceNode', 'Comment' } },
        },
      },
    },
  })
  require('luasnip.loaders.from_lua').lazy_load({ paths = vim.fn.stdpath('config') .. '/snippets' })
  require('luasnip.loaders.from_vscode').lazy_load()
  require('luasnip.loaders.from_vscode').lazy_load({
    paths = { './snippets/' },
  })
end

return config
