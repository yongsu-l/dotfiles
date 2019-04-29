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
Plug 'scrooloose/nerdtree'

" Writing
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Linter
Plug 'w0rp/ale'

" Organization
Plug 'vimwiki/vimwiki'
Plug 'godlygeek/tabular'
Plug 'lervag/vimtex'

" Syntax
Plug 'sheerun/vim-polyglot'

call plug#end()

nnoremap j gj
nnoremap k gk

set hidden

set signcolumn=yes

set completeopt=menu,preview

set list listchars=nbsp:¬,tab:│·,trail:·,extends:→

set encoding=utf-8

set splitright
set wildmenu

set shiftwidth=4
set softtabstop=4
set tabstop=4

set noswapfile

filetype plugin indent on
" set autoindent
set scrolloff=5

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
nnoremap <leader>g :GFiles<cr>
nnoremap <leader>s :Snippets<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>t :Tags<cr>

nnoremap <C-n> :NERDTreeToggle<cr>

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:fzf_action = {
			\ 'ctrl-t': 'tab split',
			\ 'ctrl-s': 'split',
			\ 'ctrl-v': 'vsplit' }

let g:vimwiki_list = [{'path': '~/Dropbox/',
			\ 'syntax': 'markdown', 'ext': '.md'}]

let g:vimwiki_global_ext = 0

" Initialize Python VENV for pynvim and neovim
let g:python_host_prog = '/home/yong/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/home/yong/.pyenv/versions/neovim3/bin/python'

" Statusline
set statusline =
" File description
set statusline +=%f\ %h%m%r%w
" Filetype
set statusline +=%y
" GitBranch and Gutentags
set statusline +=\ %{fugitive#statusline()}
" Total number of lines in the file
set statusline +=%=%-10L
" Line, column and percentage
set statusline +=%=%-14.(%l,%c%V%)\ %P

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

set grepprg=rg\ --vimgrep

function! s:goyo_enter()
  silent !tmux set status off
  silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set noshowmode
  set noshowcmd
  set scrolloff=999
  Limelight
  " ...
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  set showmode
  set showcmd
  set scrolloff=5
  Limelight!
  " ...
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
