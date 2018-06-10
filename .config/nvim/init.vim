" Plug
call plug#begin()
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-fugitive'
Plug 'vimwiki/vimwiki'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'tpope/vim-surround'

" Colors
Plug 'chriskempson/base16-vim'

" Async Dispatch
Plug 'tpope/vim-dispatch'
Plug 'w0rp/ale'

" File Navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Omnicompletion
Plug 'ervandew/supertab'
Plug 'ternjs/tern_for_vim'
" Plug 'davidhalter/jedi-vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Syntax Related
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
call plug#end()

set splitright
set wildmenu

set noswapfile

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

set laststatus=2
" Statusline
set statusline =
" File description
set statusline +=%f\ %h%m%r%w
" Filetype
set statusline +=%y                                                  
" GitBranch need fugitive
set statusline +=\ %{fugitive#statusline()}
" Total number of lines in the file
set statusline +=%=%-10L
" Line, column and percentage
set statusline +=%=%-14.(%l,%c%V%)\ %P

let base16colorspace=256
set termguicolors 
colorscheme base16-default-dark

map <silent> <C-n> :NERDTreeToggle<cr>

let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabCrMapping = 1

let g:ale_lint_on_text_changed = 'never'
let g:ale_completion_enabled = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let mapleader=","
nnoremap <leader><space> :noh<CR>

nnoremap <leader>f :Files<cr>
nnoremap <leader>b :Buffers<cr>
