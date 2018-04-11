" Yong Su Lee 
" Version: Alpha (Copied from dougblack)
" Vim Plug {{{
call plug#begin('~/.vim/plugged')

" Misc
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Wiki
Plug 'vimwiki/vimwiki'

" Colors
Plug 'sjl/badwolf'
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'

" Auto Completion
Plug 'maralla/completor.vim'

" Linter
Plug 'w0rp/ale'

" Status Line
Plug 'itchyny/lightline.vim'

" File Navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'

" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" Snippets
Plug 'epilande/vim-react-snippets'
Plug 'SirVer/ultisnips'

" Javascript/React Development
Plug 'pangloss/vim-javascript'
"Plug 'jelera/vim-javascript-syntax'
"Plug 'othree/yajs'
Plug 'mxw/vim-jsx'

" Markdown Preview
Plug 'JamshedVesuna/vim-markdown-preview'

call plug#end()
" }}}
" Colors {{{
syntax enable           " enable syntax processing
colorscheme badwolf
set background=dark
" }}}
" Misc {{{
set nocompatible
set backspace=indent,eol,start
set encoding=utf-8
set ttyfast
set laststatus=2
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
" Swap Backup Undo {{{

set backup
"set undofile

"set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//
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
nnoremap <space> za
set foldmethod=indent   " fold based on indent level
set foldnestmax=10      " max 10 depth
set foldenable          " don't fold files by default on open
set foldlevelstart=10   " start with fold level of 1
" }}}
" Line Shortcuts {{{
nnoremap j gj
nnoremap k gk
" }}}
" Vimwiki {{{
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
" }}}
" Ale {{{
let g:ale_lint_on_text_changed = 'never'
let g:ale_completion_enabled = 1
" }}}
" Leader Shortcuts {{{
let mapleader=","
nnoremap <leader><space> :noh<CR>
" }}}
" Tab Shortcuts {{{
nnoremap <C-t>     :tabnew<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
" }}}
" Completor {{{
" }}}
" Lightline {{{
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }
" }}}
" FZF {{{
nnoremap <leader>f :Files<cr>
nnoremap <leader>b :Buffers<cr>
let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
  \ -g "!*.{min.js,swp,o,zip}" 
  \ -g "!{.git,node_modules,vendor}/*" '

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)
'
'
" }}}

" vim:foldmethod=marker:foldlevel=0
