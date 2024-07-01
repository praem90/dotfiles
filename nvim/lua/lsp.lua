-- require'lspconfig'.intelephense.setup{}

require("neodev").setup({})

require'lspconfig'.lua_ls.setup{}

require'lspconfig'.phpactor.setup{
    capabilities = require('cmp_nvim_lsp').default_capabilities()
}
require'lspconfig'.vimls.setup{}
require'lspconfig'.html.setup{}
require'lspconfig'.tsserver.setup{}
-- require'lspconfig'.pyright.setup{}
require("rust-tools").setup()
require'lspconfig'.angularls.setup{}

require'lspconfig'.gopls.setup{}

require'lspconfig'.clangd.setup{}

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
  end
})
