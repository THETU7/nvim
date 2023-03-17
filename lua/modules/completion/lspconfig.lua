local lspconfig = require('lspconfig')

local lsp = require('mason-lspconfig.settings').current.ensure_installed

local capabilities = require('cmp_nvim_lsp').default_capabilities()
for _, value in ipairs(lsp) do
  lspconfig[value].setup({ capabilities = capabilities })
end

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})

local capabilities_clangd = vim.lsp.protocol.make_client_capabilities()
capabilities_clangd = require('cmp_nvim_lsp').default_capabilities(capabilities_clangd)
capabilities_clangd.offsetEncoding = { 'utf-16' }

lspconfig.clangd.setup({ capabilities = capabilities_clangd })
