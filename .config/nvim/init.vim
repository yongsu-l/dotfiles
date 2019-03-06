" Plug
call plug#begin()

Plug 'editorconfig/editorconfig-vim'

Plug 'tpope/vim-fugitive'

" Comments
Plug 'tpope/vim-commentary'

" Colors
Plug 'chriskempson/base16-vim'

" Development
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

" File Navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" " Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Linter
Plug 'w0rp/ale'
Plug 'sheerun/vim-polyglot'

" Organization
Plug 'lervag/vimtex'
Plug 'junegunn/goyo.vim'
Plug 'vimwiki/vimwiki'

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

" Statusline
if filereadable(expand("~/.config/nvim/statusline.vim"))
	exec 'source ~/.config/nvim/statusline.vim'
endif

colorscheme base16-default-dark

map <F8> :setlocal spell! spelllang=en_us<CR>

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

let g:goyo_width = 82

let g:lightline = {
	\ 'colorscheme': 'seoul256',
	\ }


let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
