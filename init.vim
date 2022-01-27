"""""""""
" display

" jellybeans theme, with black background instead of grey
let g:jellybeans_use_term_italics = 1
let g:jellybeans_overrides = {
\  "background":   {"guibg": "000000"},
\  "StatusLine":   {"guifg": "bcbcbc", "guibg": "444444"},
\  "StatusLineNC": {"guifg": "000000", "guibg": "262626"},
\  "VertSplit":    {"guifg": "262626", "guibg": "262626"},
\}
colorscheme jellybeans

" highlight current cursor line, with a notch after column 80
set cursorline
set colorcolumn=81

" show line numbers
set number

" I = skip intro message on startup
set shortmess+=I

" display invisible characters as per 'listchars' option
set list


""""""""""
" keyboard

" change <Leader> from default '\' to home-row-friendly ';'
let mapleader = ";"

" arrow keys navigate splits in normal mode; use hjkl for movement.
nmap <Up> <C-W><Up>
nmap <Down> <C-W><Down>
nmap <Left> <C-W><Left>
nmap <Right> <C-W><Right>

" move lines up/down, reindenting
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" reselect visual block after shifting indentation
vnoremap < <gv
vnoremap > >gv


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
set softtabstop=0 " disable
set shiftwidth=0 " when zero, the tabstop value is used

" use clipboard for all operations, without explicit +/* registers.
set clipboard+=unnamedplus

" lines to keep above/below cursor when scrolling
set scrolloff=3

" Show effect of command incrementally; :%s/foo/bar/g etc
"nosplit": Shows the effects of a command incrementally, as you type.
"split"  : Also shows partial off-screen results in a preview window.
set inccommand=split


""""""""""""
" file types

" assume shell scripts as bash; fixes $(subcommand) syntax highlighting.
" https://github.com/neovim/neovim/blob/253f6f3b/runtime/syntax/sh.vim#L16
let g:is_bash=1

autocmd FileType ruby inoreabbrev <buffer> pry! require "pry"; binding.pry


"""""""""
" plugins

" vim-go
let g:go_auto_sameids = 1 " highlight other instances of identifier under cursor
let g:go_updatetime = 200 " delay (ms) for sameids, type_info etc (default 800)
let g:go_gopls_complete_unimported = 1 " include suggestions from unimported packages

" deoplete
let g:deoplete#enable_at_startup = 1
set completeopt-=preview " disable the preview window feature (see FAQ)

" fzf
nmap <C-p> :FZF<CR>

" vim-asm_ca65
let g:asm_ca65_wdc = 1
filetype plugin indent on
augroup filetypedetect
    autocmd BufEnter *.s setlocal filetype=asm_ca65 colorcolumn=17,41
    autocmd BufEnter *.s highlight ColorColumn ctermbg=232
    autocmd BufLeave *.s highlight ColorColumn ctermbg=0
augroup END

" rust.vim
let g:rustfmt_autosave = 1

lua <<EOF
require('lspconfig').rust_analyzer.setup{}
EOF
