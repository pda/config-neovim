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

-- highlight current cursor line, with a notch after column 100
vim.opt.cursorline = true
vim.opt.colorcolumn = "101"

-- maximum width of text being inserted before hard-wrapping.
-- This affects manual `gq` wrapping, see also :help formatoptions
vim.opt.textwidth = 100

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

-- Ruby: use the sane “variable” indentation, not the insane default “hanging” style.
-- https://github.com/vim-ruby/vim-ruby/blob/vim8.2/doc/ft-ruby-indent.txt#L84-L106
vim.g.ruby_indent_assignment_style = "variable"

vim.cmd [[
  autocmd FileType ruby inoreabbrev <buffer> pry! require "pry"; binding.pry
]]

-- Terraform
vim.g.terraform_fmt_on_save = true

----------
-- plugins

vim.opt.signcolumn = "yes"

-- fzf
vim.api.nvim_set_keymap("n", "<C-p>", ":Files<CR>", {})


-- vim-go
vim.g.go_auto_sameids = 1 -- highlight other instances of identifier under cursor
vim.g.go_updatetime = 200 -- delay (ms) for sameids, type_info etc (default 800)
vim.g.go_gopls_complete_unimported = 1 -- include suggestions from unimported packages

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

-- what was this for? solargraph completion? cmp?
-- vim.opt.completeopt = "menu,menuone,noselect"

-------------
-- LSP

local lspconfig = require("lspconfig")
local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Go: gopls
lspconfig.gopls.setup({
  capabilities = cmp_capabilities,
})

-- Rust: rust_analyzer
lspconfig.rust_analyzer.setup({
  capabilities = cmp_capabilities,
})

-- C: clangd
lspconfig.clangd.setup({
  capabilities = cmp_capabilities,
})

-- YAML: yamlls
-- redhat-developer/yaml-language-store
lspconfig.yamlls.setup({
  capabilities = cmp_capabilities,
  settings = {
    yaml = {
      {schemaStore = {enable = true}},
    },
  }
})

-- Ruby: Ruby LSP
-- https://shopify.github.io/ruby-lsp/
lspconfig.ruby_ls.setup({
  capabilities = cmp_capabilities,
  on_attach = function(client, buffer)
    setup_diagnostics(client, buffer)
  end,
})
-- https://github.com/Shopify/ruby-lsp/blob/main/EDITORS.md
-- textDocument/diagnostic support until 0.10.0 is released
_timers = {}
local function setup_diagnostics(client, buffer)
  if require("vim.lsp.diagnostic")._enable then
    return
  end
  local diagnostic_handler = function()
    local params = vim.lsp.util.make_text_document_params(buffer)
    client.request("textDocument/diagnostic", { textDocument = params }, function(err, result)
      if err then
        local err_msg = string.format("diagnostics error - %s", vim.inspect(err))
        vim.lsp.log.error(err_msg)
      end
      local diagnostic_items = {}
      if result then
        diagnostic_items = result.items
      end
      vim.lsp.diagnostic.on_publish_diagnostics(
        nil,
        vim.tbl_extend("keep", params, { diagnostics = diagnostic_items }),
        { client_id = client.id }
      )
    end)
  end
  diagnostic_handler() -- to request diagnostics on buffer when first attaching
  vim.api.nvim_buf_attach(buffer, false, {
    on_lines = function()
      if _timers[buffer] then
        vim.fn.timer_stop(_timers[buffer])
      end
      _timers[buffer] = vim.fn.timer_start(200, diagnostic_handler)
    end,
    on_detach = function()
      if _timers[buffer] then
        vim.fn.timer_stop(_timers[buffer])
      end
    end,
  })
end

----------
-- cmp

local cmp = require("cmp")
cmp.setup({
  mapping = {
    ['<CR>'] = cmp.mapping.confirm(),
    ['<C-e>'] = cmp.mapping.abort(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ['<Tab>'] = function(fallback)
      if cmp.visible() then cmp.select_next_item() else fallback() end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then cmp.select_prev_item() else fallback() end
    end,
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "buffer", option = {
      get_bufnrs = function() return vim.api.nvim_list_bufs() end
    }},
  })
})

---------------
-- Treesitter

require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'bash',
    'go',
    'java',
    'json',
    'lua',
    'ruby',
    'yaml',
  },
  highlight = {
    enable = true,
  },
})
