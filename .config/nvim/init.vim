" Plug
call plug#begin()

Plug 'editorconfig/editorconfig-vim'

Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-fugitive'
" Git Commit Visuals
Plug 'mhinz/vim-signify'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" " Colors
Plug 'chriskempson/base16-vim'

" " Comments
Plug 'tpope/vim-commentary'

" File Navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'rhysd/vim-grammarous'

" Auto Completion
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'ervandew/supertab'
" Plug 'davidhalter/jedi-vim'
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
" Plug 'w0rp/ale'

" Language Servers and syntax linting
" Plug 'w0rp/ale'
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }

" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Syntax Related
Plug 'sheerun/vim-polyglot'

" Organization
" Plug 'vimwiki/vimwiki'
Plug 'lervag/vimtex'

" Language Specific Tools
" Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}

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

" autocmd FileType php setlocal omnifunc=phpactor#Complete

" let g:ale_lint_on_text_changed = 'never'
" let b:ale_fixers = {'jsx': ['prettier', 'eslint']}

let mapleader=","
nnoremap <leader><space> :noh<CR>
nnoremap <leader>f :Files<cr>
nnoremap <leader>b :Buffers<cr>

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

command! -nargs=0 Prettier :CocCommand prettier.formatFile
command! -nargs=0 Format :call CocAction('format')
