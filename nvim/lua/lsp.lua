local sumneko_root_path = '/home/praem90/packages/lua-language-server'
local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"
local rt = require("rust-tools")

--[[ require'lspconfig'.sumneko_lua.setup{
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    -- on_attach=require'completion'.on_attach
} ]]
--[[ require'lspconfig'.intelephense.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.phpactor.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.vimls.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.html.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.tsserver.setup{on_attach=require'completion'.on_attach} ]]

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
rt.setup()
require'lspconfig'.angularls.setup{}

