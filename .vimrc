" Yong Su Lee 
" Version: Alpha (Copied from dougblack)
" Vim Plug {{{
call plug#begin('~/.vim/plugged')

" Misc
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Wiki
Plug 'vimwiki/vimwiki'

" Colors
Plug 'arcticicestudio/nord-vim'

" Async Dispatch
Plug 'tpope/vim-dispatch'

" Auto Completion
Plug 'maralla/completor.vim'

" Linter
Plug 'w0rp/ale'

" Status Line
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'

" File Navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"Plug 'airblade/vim-rooter'

" Snippets
Plug 'epilande/vim-react-snippets'
Plug 'SirVer/ultisnips'

" Syntax Related
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Plug 'plasticboy/vim-markdown'

call plug#end()
" }}}
" Colors {{{
syntax enable           " enable syntax processing
set termguicolors
let g:nord_comment_brightness = 20
colorscheme nord
" }}}
" Misc {{{
set nocompatible
set backspace=indent,eol,start
set encoding=utf-8
set laststatus=2
set splitright
set wildmenu
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
set showmatch           " higlight matching parenthesis
" }}}
" Searching {{{
set ignorecase          " ignore case when searching
set incsearch           " search as characters are entered
set hlsearch            " highlight all matches
" }}}
" Folding {{{
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
let g:vimwiki_global_ext = 0
" }}}
" Ale {{{
let g:ale_lint_on_text_changed = 'never'
let g:ale_completion_enabled = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
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
" let g:completor_auto_trigger = 0
" inoremap <expr> <Tab> pumvisible() ? "<C-N>" : "<C-R>=completor#do('complete')<CR>"
set shortmess+=c
" }}}
" Lightline {{{
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
" }}}
" Latex {{{
" autocmd BufWritePost *.tex Dispatch! latexmk -pdf %
command LatexPreview Dispatch! latexmk -pdf %
" }}}

" vim:foldmethod=marker:foldlevel=0
