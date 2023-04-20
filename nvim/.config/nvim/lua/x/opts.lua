-- vim options
vim.g.mapleader = ' '
vim.g.syntax = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.number = true
vim.o.numberwidth = 4
vim.o.relativenumber = true
vim.o.signcolumn = 'yes:1'
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.wo.wrap = false
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.hidden = true
vim.o.scrolloff = 8
vim.o.updatetime = 250
vim.o.encoding = 'UTF-8'
vim.o.mouse = 'a'
vim.o.cursorline = true
vim.o.swapfile = false
vim.go.clipboard = 'unnamedplus'

-- highlight yanked selection
local group = vim.api.nvim_create_augroup("GlobalAutoCmds", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", { callback = function() vim.highlight.on_yank() end, group = group })

vim.notify = require("notify")
