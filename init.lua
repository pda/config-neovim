----------
-- display

-- jellybeans theme, with black background instead of grey
vim.g.jellybeans_use_term_italics = true
vim.g.jellybeans_overrides = {
  background =   {guibg = "000000"},
  StatusLine =   {guifg = "bcbcbc", guibg = "444444"},
  StatusLineNC = {guifg = "000000", guibg = "262626"},
  VertSplit =    {guifg = "262626", guibg = "262626"},
}

vim.cmd "colorscheme jellybeans"

-- highlight current cursor line, with a notch after column 80
vim.opt.cursorline = true
vim.opt.colorcolumn = "81"

-- show line numbers
vim.opt.number = true

-- I = skip intro message on startup
vim.opt.shortmess:append("I")

-- display invisible characters as per 'listchars' option
vim.opt.list = true

-----------
-- keyboard

-- change <Leader> from default '\' to home-row-friendly ';'
vim.g.mapleader = ";"

-- arrow keys navigate splits in normal mode; use hjkl for movement.
vim.api.nvim_set_keymap("n", "<Up>", "<C-W><Up>", {})
vim.api.nvim_set_keymap("n", "<Down>", "<C-W><Down>", {})
vim.api.nvim_set_keymap("n", "<Left>", "<C-W><Left>", {})
vim.api.nvim_set_keymap("n", "<Right>", "<C-W><Right>", {})

-- move lines up/down, reindenting
vim.api.nvim_set_keymap("n", "<C-j>", ":m .+1<CR>==", {noremap = true})
vim.api.nvim_set_keymap("n", "<C-k>", ":m .-2<CR>==", {noremap = true})
vim.api.nvim_set_keymap("v", "<C-j>", ":m '>+1<CR>gv=gv", {noremap = true})
vim.api.nvim_set_keymap("v", "<C-k>", ":m '<-2<CR>gv=gv", {noremap = true})

-- reselect visual block after shifting indentation
vim.api.nvim_set_keymap("v", "<", "<gv", {noremap = true})
vim.api.nvim_set_keymap("v", ">", ">gv", {noremap = true})

--------
-- mouse

-- Mouse for scrolling etc in console.
-- a = normal + visual + insert + command-line + help files
vim.opt.mouse = "a"

-----------
-- behavior

-- indent with two spaces by default
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 0 -- disable
vim.opt.shiftwidth = 0 -- when zero, the tabstop value is used

-- use clipboard for all operations, without explicit +/* registers.
vim.opt.clipboard:append("unnamedplus")

-- lines to keep above/below cursor when scrolling
vim.opt.scrolloff = 3

-- Show effect of command incrementally; :%s/foo/bar/g etc
-- "nosplit": Shows the effects of a command incrementally, as you type.
-- "split"  : Also shows partial off-screen results in a preview window.
vim.opt.inccommand = "split"

-------------
-- file types

-- assume shell scripts as bash; fixes $(subcommand) syntax highlighting.
-- https://github.com/neovim/neovim/blob/253f6f3b/runtime/syntax/sh.vim#L16
vim.g.is_bash = true

vim.cmd [[
  autocmd FileType ruby inoreabbrev <buffer> pry! require "pry"; binding.pry
]]

----------
-- plugins

-- vim-go
vim.g.go_auto_sameids = 1 -- highlight other instances of identifier under cursor
vim.g.go_updatetime = 200 -- delay (ms) for sameids, type_info etc (default 800)
vim.g.go_gopls_complete_unimported = 1 -- include suggestions from unimported packages

-- deoplete
vim.g["deoplete#enable_at_startup"] = true
vim.opt.completeopt:remove("preview") -- disable the preview window feature (see FAQ)

-- fzf
vim.api.nvim_set_keymap("n", "<C-p>", ":FZF<CR>", {})

-- vim-asm_ca65
vim.g.asm_ca65_wdc = true
vim.cmd "filetype plugin indent on"
vim.cmd [[
  augroup filetypedetect
      autocmd BufEnter *.s setlocal filetype=asm_ca65 colorcolumn=17,41
      autocmd BufEnter *.s highlight ColorColumn ctermbg=232
      autocmd BufLeave *.s highlight ColorColumn ctermbg=0
  augroup END
]]

-- rust.vim
vim.g.rustfmt_autosave = true
require('lspconfig').rust_analyzer.setup{}
