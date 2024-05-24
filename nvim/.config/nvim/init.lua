vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ General options ]]
--
-- Make line numbers default
vim.opt.number = true

-- Enable mouse mode
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = "unnamedplus"

-- Enable break indent
vim.opt.breakindent = true

-- Default tab size to 4 spaces
vim.opt.tabstop = 4

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Display certain whitespace in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Dont wrap lines longer than screen
vim.opt.wrap = false

-- Disable default provider plugins (they seem to cause slowness on Mac)
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("rzauls-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Global keyumaps
require("custom.keymaps")

-- Install `lazy.nvim` plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Configure and install plugins
local plugins = {
	-- Any plugins that dont really need any additional configuration
	{ "tpope/vim-sleuth" }, -- Detect tabstop and shiftwidth automatically
	{ "numToStr/Comment.nvim", opts = {} }, -- "gc" to comment visual regions/lines
	{ "j-hui/fidget.nvim", opts = {} },

	-- Autoload all plugins from `lua/custom/plugins` directory
	-- Doing this allows these to be less stable and break, without bricking the whole init.lua setup
	-- (only that single lua import would fail and report its failings)
	{ import = "custom.plugins" },
}

require("lazy").setup(plugins, {
	change_detection = {
		enabled = true,
		notify = false,
	},
})
