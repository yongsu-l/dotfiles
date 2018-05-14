" Plug {{{
call plug#begin()
  " Autocomplete
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
	" For func argument completion
	Plug 'Shougo/neosnippet'
	Plug 'Shougo/neosnippet-snippets'

	Plug 'tpope/vim-fugitive'

	" Wiki
	Plug 'vimwiki/vimwiki'

	" Colors
	Plug 'arcticicestudio/nord-vim'

	" Async Dispatch
	Plug 'tpope/vim-dispatch'

	Plug 'w0rp/ale'

	" Status Line
	Plug 'itchyny/lightline.vim'
	Plug 'edkolev/tmuxline.vim'

	" File Navigation
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'


	" Syntax Related
	Plug 'pangloss/vim-javascript'
	Plug 'mxw/vim-jsx'
	Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()
" }}}

syntax enable           " enable syntax processing
set termguicolors
let g:nord_comment_brightness = 20
colorscheme nord

set splitright
set wildmenu

set tabstop=2           " 4 space tab
set expandtab           " use spaces for tabs
set softtabstop=2       " 4 space tab
set shiftwidth=2
set modelines=1
filetype indent on
filetype plugin on
set autoindent

set number
set showcmd
set nocursorline
set showmatch

set ignorecase
set incsearch
set hlsearch

nnoremap j gj
nnoremap k gk

let g:ale_lint_on_text_changed = 'never'
let g:ale_completion_enabled = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let mapleader=","
nnoremap <leader><space> :noh<CR>

let g:lightline = {
      \ 'colorscheme': 'nord',
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
let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
  \ -g "!*.{min.js,swp,o,zip}" 
  \ -g "!{.git,node_modules,vendor}/*" '
command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)


" deoplete

let g:deoplete#enable_at_startup = 1

" neosnippet
        
let g:neosnippet#enable_completed_snippet = 1
