vim.opt.laststatus = 2
return {
	{ "milisims/nvim-luaref" }, -- Lua help in :help
	{ "tpope/vim-sleuth" }, -- Detect tabstop and shiftwidth automatically
	{ "j-hui/fidget.nvim", opts = {} }, -- Loaders/progress bars
	{ "dzirtusss/netrw_keepdir_fix" }, -- Fix netrw 'mc' on mac
}
