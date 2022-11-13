"<leader> remapped to <Space>
nnoremap <SPACE> <Nop>
let mapleader="\<Space>"

"TODO: convert these to lua at some point
"see ':help vim.opt' and ':help vim.o'
set nocompatible
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile
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
"TODO: fix delete buffer interactions
"TODO: there probabbly is a better way to do this
nnoremap yy "+yy
vnoremap y "+y

nnoremap p "+p
vnoremap p "+p
nnoremap P "+P
vnoremap P "+P

"Plugins
call plug#begin('~/.config/nvim/plugged')
"telescope/system plugins
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope.nvim', {'tag': '0.1.0'}
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
"lsp/autocomplete
Plug 'neovim/nvim-lspconfig' "premade lsp configurations with sane defaults
Plug 'hrsh7th/nvim-cmp' "autocomplete base layer
"autocomplete suggesstion improvements
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip', {'tag': 'v1.*'}

" decorative fluff
Plug 'sainnhe/gruvbox-material' "theme
Plug 'kyazdani42/nvim-web-devicons' "icons

" git permalinks
Plug 'ruifm/gitlinker.nvim'

call plug#end()

" theme stuff
set background=dark
set termguicolors
colorscheme gruvbox-material

" load lua config
lua require('elite')

" NOTE: all keybinds are configured in lua configs, except this one
" lua config reload with F4 button
nnoremap <F4> :lua package.loaded.elite = nil <cr>:source ~/.config/nvim/init.vim <cr>
