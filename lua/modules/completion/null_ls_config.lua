local null_ls = require('null-ls')
local formatter = null_ls.builtins.formatting
--local diagnostics = null_ls.builtins.diagnostics

local sources = {
  formatter.gofmt,
  formatter.clang_format,
  --[[
  formatter.stylua,
  formatter.prettierd,
  formatter.black.with({ extra_args = { "--line-length=79" } }),
  formatter.gofmt,
  formatter.clang_format,
  formatter.prettier.with({
    filetypes = {
      "markdown",
      "yaml",
      "graphql",
      "handlebars",
      "json",
      "css",
      "scss",
      "less",
      "html",
      "json",
      "jsonc",
    },
  }),
  diagnostics.eslint_d,
  --diagnostics.flake8,
  diagnostics.protolint,
  -- require("null-ls").builtins.completion.spell,
  ]]
  --
}

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      -- apply whatever logic you want (in this example, we'll only use null-ls)
      return client.name == 'null-ls'
    end,
    bufnr = bufnr,
  })
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

null_ls.setup({
  sources = sources,
  on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          lsp_formatting(bufnr)
        end,
      })
    end
  end,
})
