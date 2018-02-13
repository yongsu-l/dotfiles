" Yong Su Lee 
" Version: Alpha (Copied from dougblack)
" Vim Plug {{{
call plug#begin('~/.vim/plugged')
"Plug 'bling/vim-airline'
Plug 'kien/ctrlp.vim'
Plug 'moll/vim-node'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/vim-easy-align'
"Plug 'vim-airline/vim-airline-themes'
Plug 'vimwiki/vimwiki'
"Plug 'joshdick/onedark.vim'
Plug 'rakr/vim-one'
Plug 'scrooloose/nerdcommenter'
call plug#end()
" }}}
" Colors {{{
syntax enable           " enable syntax processing
"colorscheme one
colorscheme badwolf
"set termguicolors
" }}}
" Misc {{{
set backspace=indent,eol,start
set encoding=utf-8
"set clipboard=unnamedplus
" }}}
" Spaces & Tabs {{{
set tabstop=2           " 4 space tab
set expandtab           " use spaces for tabs
set softtabstop=2       " 4 space tab
set shiftwidth=2
set modelines=1
filetype indent on
filetype plugin on
set autoindent
" }}}
" UI Layout {{{
set number              " show line numbers
set showcmd             " show command in bottom bar
set nocursorline        " highlight current line
set wildmenu
set lazyredraw
set showmatch           " higlight matching parenthesis
" }}}
" Searching {{{
set ignorecase          " ignore case when searching
set incsearch           " search as characters are entered
set hlsearch            " highlight all matches
" }}}
" Folding {{{
"=== folding ===
set foldmethod=indent   " fold based on indent level
set foldnestmax=10      " max 10 depth
set foldenable          " don't fold files by default on open
nnoremap <space> za
set foldlevelstart=10   " start with fold level of 1
" }}}
" Backup and Swap {{{
set directory=~/.vim/.swp//
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
" }}}
" Line Shortcuts {{{
nnoremap j gj
nnoremap k gk
" }}}
" Ale {{{
let b:ale_fixers = ['autopep8', 'yapf']
let b:ale_linters = ['flake8']
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_completion_enabled = 1
let g:airline#extensions#ale#enabled = 1
" }}}
" CtrlP {{{
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = '\vbuild/|dist/|venv/|target/|\.(o|swp|pyc|egg)$'
" }}}
" airline {{{
"let g:airline_powerline_fonts = 1
"let g:airline_theme = 'badwolf'
" }}}
" React Development {{{
let g:jsx_ext_required = 0
let g:mta_filetypes = {
    \ 'javascript.js' : 1,
    \}
" }}}
" Leader Shortcuts {{{
let mapleader=","
nnoremap <leader><space> :noh<CR>
" }}}

" vim:foldmethod=marker:foldlevel=0
