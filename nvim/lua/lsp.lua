require'lspconfig'.lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
      return
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
        -- library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,
  settings = {
    Lua = {}
  }
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- require'lspconfig'.intelephense.setup{}
require'lspconfig'.phpactor.setup{
    capabilities = capabilities
}
require'lspconfig'.vimls.setup{}
require'lspconfig'.html.setup{}
require'lspconfig'.sqlls.setup{
	root_dir = require'lspconfig'.util.find_git_ancestor,
	single_file_support=true
}
-- require'lspconfig'.tsserver.setup{}
require'lspconfig'.ts_ls.setup{}
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

