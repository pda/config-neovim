~pda/.config/nvim/
==================

In 2010 my [vim configuration][dotvim] entered version control, and for seven
years it accreted options, plugins, bindings and hacks. I strove to keep it
lean and minimal, but the years were not kind.

Enter 2017, [Neovim][neovim] is gaining popularity over [o.g. vim][vim]. A
quick test drive with my full vim configuration found it much faster and more
responsive than vim 8.0, which was frustratingly sluggish at 27" full-screen.

This repository, then, is a complete yet selective rewrite, reconsidering each
line of configuration and each plugin for its worth. Many options have since
become default (or been removed completely), and many plugins became largely
redundant with behaviour since built in to vim/neovim. Some plugins related to
hobbies currently shelved. If I miss any functionality, I'll try to adapt to a
new way, and failing that will gradually add a few more plugins and bindings.

I run Neovim in tmux in iTerm2 on macOS.

```sh
# install
git clone --recursive https://github.com/pda/config-nvim.git ~/.config/nvim

# upgrade all plugins (commit per plugin)
./upgrade-plugins
```


[dotvim]: https://github.com/pda/dotvim
[vim]: http://www.vim.org/
[neovim]: https://neovim.io/
