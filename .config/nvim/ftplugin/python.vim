" In ~/.vim/ftplugin/python.vim
setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab

set nolinebreak
set nowrap

" Check Python files with flake8 and pylint.
let b:ale_linters = ['flake8']
" Fix Python files with autopep8 and yapf.
let b:ale_fixers = ['autopep8', 'black']
" Disable warnings about trailing whitespace for Python files.
let b:ale_warn_about_trailing_whitespace = 0

let g:jedi#popup_on_dot = 0
