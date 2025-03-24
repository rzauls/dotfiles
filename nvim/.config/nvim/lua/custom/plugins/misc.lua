vim.opt.laststatus = 2
return {
	{ "milisims/nvim-luaref", event = "VeryLazy" }, -- Lua help in :help
	{ "tpope/vim-sleuth", event = "VeryLazy" }, -- Detect tabstop and shiftwidth automatically
	{ "j-hui/fidget.nvim", event = "VeryLazy", opts = {} }, -- Loaders/progress bars
	{ "dzirtusss/netrw_keepdir_fix", event = "VeryLazy" }, -- Fix netrw 'mc' on mac
}
