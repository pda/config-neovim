"""""""""
" display

" jellybeans theme, with black background instead of grey
let g:jellybeans_overrides = {"background": {"guibg": "000000"}}
colorscheme jellybeans

" show line numbers
set number


""""""""""
" keyboard

" change <Leader> from default '\' to home-row-friendly ';'
let mapleader = ";"

" arrow keys navigate splits in normal mode; use hjkl for movement.
nmap <Up> <C-W><Up>
nmap <Down> <C-W><Down>
nmap <Left> <C-W><Left>
nmap <Right> <C-W><Right>


""""""""""
" behavior

" indent with two spaces by default
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
