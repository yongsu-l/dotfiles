" Statusline
set statusline =
" File description
set statusline +=%f\ %h%m%r%w
" Filetype
set statusline +=%y
" GitBranch need fugitive
if exists("fugitive#statusline")
	set statusline +=\ %{fugitive#statusline()}
endif
" " Coc Integram
if exists("coc#status")
	set statusline +=\ %{coc#status()}
endif
" Total number of lines in the file
set statusline +=%=%-10L
" Line, column and percentage
set statusline +=%=%-14.(%l,%c%V%)\ %P
