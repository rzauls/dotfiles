"NOTE: this config is only compatible with neovim 0.7 and upwards
"<leader> remapped to <Space>
nnoremap <SPACE> <Nop>
let mapleader="\<Space>"

" load lua config
" this contains most of the configuration and plugin setup
lua require('entry')

"TODO: convert these to lua at some point
"see ':help vim.opt' and ':help vim.o'
set nocompatible
set noswapfile
set nobackup
syntax on

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set number
set numberwidth=4
set relativenumber
set signcolumn=yes:1
set incsearch
set hlsearch
set ignorecase
set smartcase
set nowrap
set splitbelow
set splitright
set hidden
set scrolloff=8
set updatetime=250
set encoding=UTF-8
set mouse=a
set cursorline

"copy/paste to system clipboard
set clipboard+=unnamedplus

"highlight on yank
au TextYankPost * silent! lua vim.highlight.on_yank()

" theme
set background=dark
set termguicolors
colorscheme gruvbox-material

" NOTE: all keybinds are configured in lua configs, except this one
" lua config reload with F4 button
nnoremap <F4> :lua package.loaded.entry = nil <cr>:source ~/.config/nvim/init.vim <cr>
