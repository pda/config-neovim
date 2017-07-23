"""""""""
" display

" jellybeans theme, with black background instead of grey
let g:jellybeans_overrides = {"background": {"guibg": "000000"}}
colorscheme jellybeans

" highlight current cursor line, with a notch after column 80
set cursorline
set colorcolumn=81

" show line numbers
set number

" I = skip intro message on startup
set shortmess=I


""""""""""
" keyboard

" change <Leader> from default '\' to home-row-friendly ';'
let mapleader = ";"

" arrow keys navigate splits in normal mode; use hjkl for movement.
nmap <Up> <C-W><Up>
nmap <Down> <C-W><Down>
nmap <Left> <C-W><Left>
nmap <Right> <C-W><Right>


"""""""
" mouse

" Mouse for scrolling etc in console.
" a = normal + visual + insert + command-line + help files
set mouse=a


""""""""""
" behavior

" indent with two spaces by default
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" use clipboard for all operations, without explicit +/* registers.
set clipboard+=unnamedplus
