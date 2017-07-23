" vendored from https://github.com/pda/tslime.vim
" which was my cut-down fork of https://github.com/xaviershay/tslime.vim
" which was forked from https://github.com/jimmyharris/tslime.vim

""""""""""""""
" key mappings

" Send "!!" to tmux, to repeat last shell command.
map <Leader>!! :wall \| call Send_to_Tmux("!!\n")<CR>

" make
map <Leader>m :wall \| :call Send_to_Tmux("make\n")<CR>

" RSpec: Set a current spec file with R, execute it via tmux with r.
map <Leader>R :let g:specFile = @% \| echo "RSpec file: " . g:specFile<CR>
map <Leader>r :wall \| :call Send_to_Tmux("time rspec -f d " . g:specFile . "\n")<CR>

"""""""""""
" functions

function! Send_to_Tmux(text)
  call system("tmux set-buffer  '" . substitute(a:text, "'", "'\\\\''", 'g') . "'" )
  call system("tmux paste-buffer -t " . s:tmux_pane_number())
endfunction

function! s:tmux_pane_number()
  if !exists("g:tmux_pane_number")
    let g:tmux_pane_number = input("pane number: ", "")
  end
  return g:tmux_pane_number
endfunction
