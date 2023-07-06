-- local sumneko_root_path = '/home/praem90/packages/lua-language-server'
-- local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"

--[[ require'lspconfig'.sumneko_lua.setup{
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    -- on_attach=require'completion'.on_attach
} ]]

require'lspconfig'.intelephense.setup{}
require'lspconfig'.phpactor.setup{}
require'lspconfig'.vimls.setup{}
require'lspconfig'.html.setup{}
require'lspconfig'.sqlls.setup{
	root_dir = require'lspconfig'.util.find_git_ancestor,
	single_file_support=true
}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.pyright.setup{}
require("rust-tools").setup()
require'lspconfig'.angularls.setup{}

require'lspconfig'.gopls.setup{
    cmd = {"gopls", "serve"},
}
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
  end
})

