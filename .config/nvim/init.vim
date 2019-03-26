" Plug
call plug#begin()

Plug 'editorconfig/editorconfig-vim'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'mhinz/vim-signify'

" Comments
Plug 'tpope/vim-commentary'

" Colors
Plug 'chriskempson/base16-vim'

" File Navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
" Plug 'ervandew/supertab'

" Linter
Plug 'w0rp/ale'

" Organization
Plug 'junegunn/goyo.vim'
Plug 'vimwiki/vimwiki'

" Syntax
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'

Plug 'fatih/vim-go'

call plug#end()

" set path=.,**

set hidden

set signcolumn=yes

set completeopt=menu,preview

set list listchars=tab:│·,trail:·,extends:→

set encoding=utf-8

set splitright
set wildmenu

set noswapfile

filetype plugin indent on
set autoindent

set number
" Show command being typed
set showcmd
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
nnoremap <leader>t :Tags<cr>

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:fzf_action = {
			\ 'ctrl-t': 'tab split',
			\ 'ctrl-s': 'split',
			\ 'ctrl-v': 'vsplit' }

let g:vimwiki_list = [{'path': '~/Dropbox/',
			\ 'syntax': 'markdown', 'ext': '.md'}]

let g:vimwiki_global_ext = 0

let g:python_host_prog = '/home/yong/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/home/yong/.pyenv/versions/neovim3/bin/python'

" let g:gutentags_ctags_tagfile = '.git/tags'

let g:gutentags_file_list_command = {
			\ 'markers': {
			\ '.git': 'git ls-files',
			\ },
			\ }

" Statusline
set statusline =
" File description
set statusline +=%f\ %h%m%r%w
" Filetype
set statusline +=%y
" GitBranch and Gutentags
set statusline +=\ %{fugitive#statusline()}
set statusline+=%{gutentags#statusline()}
" Total number of lines in the file
set statusline +=%=%-10L
" Line, column and percentage
set statusline +=%=%-14.(%l,%c%V%)\ %P

autocmd InsertEnter * let save_cwd = getcwd() | lcd %:p:h
autocmd InsertLeave * set noautochdir | execute 'lcd' fnameescape(save_cwd)

autocmd FileType vue syntax sync fromstart
let g:vue_disable_pre_processors=1
