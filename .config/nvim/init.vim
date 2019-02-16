" Plug
call plug#begin()

Plug 'editorconfig/editorconfig-vim'

" Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-fugitive'
" " Git Commit Visuals
Plug 'mhinz/vim-signify'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Comments
Plug 'tpope/vim-commentary'

" Colors
Plug 'chriskempson/base16-vim'

" File Navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Auto Completion
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'w0rp/ale'

" " Syntax Related
Plug 'sheerun/vim-polyglot'

" Organization
Plug 'vimwiki/vimwiki'
Plug 'lervag/vimtex'
Plug 'itchyny/calendar.vim'

call plug#end()

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
" set showcmd
set cursorline
set showmatch

set ignorecase
set incsearch
set hlsearch

" Statusline
set statusline =
" File description
set statusline +=%f\ %h%m%r%w
" Filetype
set statusline +=%y
" GitBranch need fugitive
set statusline +=\ %{fugitive#statusline()}
" Coc Integram
set statusline +=\ %{coc#status()}
" Total number of lines in the file
set statusline +=%=%-10L
" Line, column and percentage
set statusline +=%=%-14.(%l,%c%V%)\ %P

" let base16colorspace=256
set termguicolors
colorscheme base16-default-dark

" Prevent screen flickering
set completeopt-=preview

map <silent> <C-n> :NERDTreeToggle<cr>

map <F8> :setlocal spell! spelllang=en_us<CR>

let mapleader=","
nnoremap <leader><space> :noh<CR>
nnoremap <leader>f :Files<cr>
nnoremap <leader>b :Buffers<cr>

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

command! -nargs=0 Format :call CocAction('format')

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Vue syntax highlighting
let g:vue_disable_pre_processors=1
autocmd FileType vue syntax sync fromstart

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"

let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

let g:vimwiki_list = [{'path': '~/Dropbox/'}]

let g:ale_linter_aliases = {'vue': ['vue', 'javascript']}
let g:ale_fixers = {
\   'vue': ['prettier', 'eslint'],
\}
