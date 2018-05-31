" Plug
call plug#begin()
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-fugitive'
Plug 'vimwiki/vimwiki'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'tpope/vim-surround'

" Colors
Plug 'chriskempson/base16-vim'
Plug 'sjl/badwolf'

" Async Dispatch
Plug 'tpope/vim-dispatch'
Plug 'w0rp/ale'

" Status Line
Plug 'itchyny/lightline.vim'

" File Navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Omnicompletion
Plug 'ervandew/supertab'
Plug 'ternjs/tern_for_vim'
Plug 'davidhalter/jedi-vim'

" Syntax Related
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()

set splitright
set wildmenu

autocmd Filetype javascript setlocal sw=2 sts=2

filetype plugin indent on
set autoindent
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

set number
set showcmd
set cursorline
set showmatch

set ignorecase
set incsearch
set hlsearch

nnoremap j gj
nnoremap k gk

" Visual block move up and down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Plugin setting
set termguicolors
colorscheme base16-default-dark

map <silent> <C-n> :NERDTreeToggle<cr>

" let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
let g:SuperTabDefaultCompletionType = "context"

let g:ale_lint_on_text_changed = 'never'
let g:ale_completion_enabled = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let mapleader=","
nnoremap <leader><space> :noh<CR>

let g:lightline = {
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'fugitive#head'
            \ },
            \ }

nnoremap <leader>f :Files<cr>
nnoremap <leader>b :Buffers<cr>
