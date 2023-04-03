syntax on
set encoding=UTF-8
set guicursor=
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
" set noshowmode
set signcolumn=yes
set isfname+=@-@
set cursorline
set nocompatible
filetype plugin on
" set ls=0

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50
set timeoutlen=500

set colorcolumn=80


let mapleader=" "

set completeopt=menuone,noinsert,noselect
set shortmess+=c
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']

call plug#begin('~/.vim/plugged')
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'

Plug 'neovim/nvim-lsp'
Plug 'neovim/nvim-lspconfig'

" Rust
Plug 'simrat39/rust-tools.nvim'

" Neovim Tree shitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" Themes
Plug 'gruvbox-community/gruvbox'
Plug 'eddyekofo94/gruvbox-flat.nvim'
Plug 'navarasu/onedark.nvim'
Plug 'rmehri01/onenord.nvim', { 'branch': 'main' }


Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'othree/yajs.vim', { 'for': 'javascript' }

Plug 'phpactor/phpactor', {'for': 'php', 'branch': 'master', 'do': 'composer install --no-dev -o'}

" Plug 'vim-airline/vim-airline'
Plug 'nvim-lualine/lualine.nvim'
" If you want to have icons in your statusline choose one of these
Plug 'kyazdani42/nvim-web-devicons'

" TODO
Plug 'vuciv/vim-bujo'
Plug 'vimwiki/vimwiki'


" tpope
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-dispatch'

" Conflicts with PHP intellephense autocomplete
" Plug 'hrsh7th/nvim-compe'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

"The most awaited VimSpector Debugger
Plug 'puremourning/vimspector'

" Plug 'codota/tabnine-vim'

" MY PHPCS and PHPCBF plugin
" Plug 'praem90/nvim-phpcsf'

" tabular plugin is used to format tables
Plug 'godlygeek/tabular'
" JSON front matter highlight plugin
Plug 'elzr/vim-json'
Plug 'plasticboy/vim-markdown'

Plug 'phpstan/vim-phpstan'

" Markdown presenter
Plug 'sotte/presenting.vim'

Plug 'mtdl9/vim-log-highlighting'
call plug#end()

au FileType markdown
let b:presenting_slide_separator = '\v(^|\n)\ze#{1,2}[^#]'


" vimspector
let g:vimspector_enable_mappings = 'HUMAN'

let g:gruvbox_flat_style = "dark"
colorscheme onenord
""" Coloring

" Opaque Background (Comment out to use terminal's profile)
set termguicolors

" Transparent Background (For i3 and compton)
hi Normal guibg=NONE ctermbg=NONE

set background=dark

" LSP settings moved to lsp.lua
lua require('lsp')

" lua require('kommentry')

lua require('lua-cmp')

" VimSpector keybindings
lua require('spector')

" lua require('eslint')

" lua require('telescope').load_extension('media_files')

lua << END
require'lualine'.setup{
    options = {theme = "onenord"}
}
END

lua require("telescope").load_extension "file_browser"


" vim-markdown settings
" disable header folding
let g:vim_markdown_folding_disabled = 1

" do not use conceal feature, the implementation is not so good
let g:vim_markdown_conceal = 0

" disable math tex conceal feature
let g:tex_conceal = ""
let g:vim_markdown_math = 1

" support front matter of various format
let g:vim_markdown_frontmatter = 1  " for YAML format
let g:vim_markdown_toml_frontmatter = 1  " for TOML format
let g:vim_markdown_json_frontmatter = 1  " for JSON format



"functions for autocommands
fun! TrimWhiteSpace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

" autocommands
augroup ERGHO
    autocmd!
    " autocmd BufWritePre *.php :lua require'phpcs'.cbf()
    " autocmd BufWritePost,BufReadPost *.php :lua require'phpcs'.cs()
    autocmd BufWritePre * :call TrimWhiteSpace()
augroup END

autocmd FileType php set iskeyword+=$ noet ci pi sts=0 sw=4 ts=4

" PHPCS
let g:nvim_phpcs_config_phpcs_path = 'phpcs'
let g:nvim_phpcs_config_phpcbf_path = 'phpcbf'
let g:nvim_phpcs_config_phpcs_standard = 'PSR12'

" Phpactor
let g:phpactorPhpBin = "/usr/bin/php"
let g:PHP_removeCRwhenUnix = 1



" Find files using Telescope command-line sugar.

nnoremap <C-f> <cmd>:lua require('telescope.builtin').find_files(require'telescope.themes'.get_dropdown({previewer = false, show_untracked = false}))<cr>
nnoremap <C-b> <cmd>:lua require('telescope.builtin').buffers(require'telescope.themes'.get_dropdown({previewer = false}))<cr>
nnoremap <C-p> <cmd>:lua require('telescope.builtin').git_files(require'telescope.themes'.get_dropdown({previewer=false,recurse_submodules = true, show_untracked = false}))<cr>
nnoremap <C-g> <cmd>:lua require('telescope.builtin').live_grep(require'telescope.themes'.get_ivy({previewer = false, show_untracked = false}))<cr>
nnoremap <leader>fg <cmd>Telescope live_grep theme=ivy<cr>
" nnoremap <C-b> <cmd>Telescope buffers<cr>
nnoremap <leader>fb <cmd>Telescope file_browser theme=dropdown previewer=false<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

nnoremap <leader>bn <cmd>bn<cr>
nnoremap <leader>bp <cmd>bp<cr>

" TODO
nmap <C-S> <Plug>BujoAddnormal
imap <C-S> <Plug>BujoAddinsert
nmap <leader>t <cmd>Todo g<CR><C-w>H
nmap <leader>s <Plug>BujoChecknormal


let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]


let g:bujo#todo_file_path = $HOME . "/.cache/bujo"

" Quick fix list
nnoremap <C-q> <cmd>copen<cr>
nnoremap <C-j> <cmd>cnext<cr>
nnoremap <C-k> <cmd>cprev<cr>

" LSP lint nav
nnoremap <leader>j <cmd>:lua vim.diagnostic.goto_next()<cr>
nnoremap <leader>k <cmd>:lua vim.diagnostic.goto_prev()<cr>

" LSP Autocomplete
nnoremap <leader>gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <leader>K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <leader>ca     <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <leader><c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <leader>gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <leader>g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <leader>gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <leader>R    <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <leader>pf    <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <leader>de    <cmd>lua vim.diagnostic.open_float()<CR>

nnoremap <leader>fw yiw/<C-R>"<CR>
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>

" Git keymaps
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gp :Dispatch git push<CR>

nnoremap <Leader>ex :Ex<CR>

nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG
nnoremap Y yy

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

inoremap <C-c> <ESC>

" Insert a new line above or below cursor
nnoremap <leader>O YPD
nnoremap <leader>o YpD

" Terminal Keymaps
  nnoremap <leader>T <c-w>v<c-\><c-n><c-w>l:term<CR>i

  " Terminal mode:
  tnoremap <Esc> <c-\><c-n>
  tnoremap <M-h> <c-\><c-n><c-w>h
  tnoremap <M-j> <c-\><c-n><c-w>j
  tnoremap <M-k> <c-\><c-n><c-w>k
  tnoremap <M-l> <c-\><c-n><c-w>l
  " Insert mode:
  inoremap <M-h> <Esc><c-w>h
  inoremap <M-j> <Esc><c-w>j
  inoremap <M-k> <Esc><c-w>k
  inoremap <M-l> <Esc><c-w>l
  " Visual mode:
  vnoremap <M-h> <Esc><c-w>h
  vnoremap <M-j> <Esc><c-w>j
  vnoremap <M-k> <Esc><c-w>k
  vnoremap <M-l> <Esc><c-w>l
  " Normal mode:
  nnoremap <M-h> <c-w>h
  nnoremap <M-j> <c-w>j
  nnoremap <M-k> <c-w>k
  nnoremap <M-l> <c-w>l
