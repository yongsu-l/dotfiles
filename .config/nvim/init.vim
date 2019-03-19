" Plug
call plug#begin()

Plug 'editorconfig/editorconfig-vim'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'

" Comments
Plug 'tpope/vim-commentary'

" Colors
Plug 'chriskempson/base16-vim'
Plug 'scrooloose/nerdtree'

" File Navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'itchyny/lightline.vim'

" Linter
Plug 'w0rp/ale'

" Organization
Plug 'junegunn/goyo.vim'
Plug 'vimwiki/vimwiki'

" Syntax
Plug 'posva/vim-vue'
Plug 'pangloss/vim-javascript'

Plug 'fatih/vim-go'

call plug#end()

set hidden

set signcolumn=yes

set list listchars=tab:│·,trail:·,extends:→
set shiftwidth=4
set softtabstop=4
set tabstop=4

set encoding=utf-8

set splitright
set wildmenu

set noswapfile

filetype plugin indent on
set autoindent

set number
set noshowcmd
set cursorline
set showmatch

set ignorecase
set incsearch
set hlsearch

set termguicolors
colorscheme base16-default-dark

let mapleader=","
nnoremap <leader><space> :noh<CR>
nnoremap <leader>f :Files<cr>
nnoremap <leader>s :Snippets<cr>
nnoremap <leader>b :Buffers<cr>

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:fzf_action = {
			\ 'ctrl-t': 'tab split',
			\ 'ctrl-s': 'split',
			\ 'ctrl-v': 'vsplit' }

let g:vimwiki_list = [{'path': '~/Dropbox/',
			\ 'syntax': 'markdown', 'ext': '.md'}]

let g:vimwiki_global_ext = 0

let g:goyo_width = 82

let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

" don't give |ins-completion-menu| messages.
" set shortmess+=c

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

map <C-n> :NERDTreeToggle<CR>

let g:lightline = {
      \ 'colorscheme': 'base16',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }
