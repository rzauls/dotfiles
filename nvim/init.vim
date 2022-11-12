"General
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
set signcolumn=auto
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
set cursorline " this maybe sucks, will see


"yank/paste to system clipboard
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


"decorative fluff
Plug 'sainnhe/gruvbox-material'
Plug 'kyazdani42/nvim-web-devicons'

"go
Plug 'fatih/vim-go'

"js/ts
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'peitalin/vim-jsx-typescript'
call plug#end()


"Plugin config
"vim-go
let g:go_highlight_types=1
let g:go_highlight_fields=1
let g:go_highlight_functions=1
let g:go_highlight_function_calls=1

"theme stuff
set background=dark
set termguicolors
colorscheme gruvbox-material

"load lua config
lua require("elite")
