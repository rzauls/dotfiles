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

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [d]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [d]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [e]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier to remember
-- NOTE: This won't work in all terminal emulators/tmux/etc.
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Netrw and file navigation
vim.keymap.set("n", "<C-e>", function()
	vim.cmd("Explore")
end, { desc = "Open file [e]xplorer" })

-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("rzauls-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Install `lazy.nvim` plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Configure and install plugins
local plugins = {
	{
		"mrjones2014/smart-splits.nvim",
		lazy = false,
		config = function()
			local smartsplits = require("smart-splits")
			-- splits
			vim.keymap.set("n", "<C-h>", smartsplits.move_cursor_left)
			vim.keymap.set("n", "<C-j>", smartsplits.move_cursor_down)
			vim.keymap.set("n", "<C-k>", smartsplits.move_cursor_up)
			vim.keymap.set("n", "<C-l>", smartsplits.move_cursor_right)
			-- rezise
			vim.keymap.set("n", "<A-h>", function()
				smartsplits.resize_left(10)
			end)
			vim.keymap.set("n", "<A-j>", smartsplits.resize_down)
			vim.keymap.set("n", "<A-k>", smartsplits.resize_up)
			vim.keymap.set("n", "<A-l>", function()
				smartsplits.resize_right(10)
			end)
			-- swap
			vim.keymap.set("n", "<leader><A-h>", smartsplits.swap_buf_left)
			vim.keymap.set("n", "<leader><A-j>", smartsplits.swap_buf_down)
			vim.keymap.set("n", "<leader><A-k>", smartsplits.swap_buf_up)
			vim.keymap.set("n", "<leader><A-l>", smartsplits.swap_buf_right)
		end,
	},
	{ "tpope/vim-sleuth" }, -- Detect tabstop and shiftwidth automatically
	{ "numToStr/Comment.nvim", opts = {} }, -- "gc" to comment visual regions/lines
	{ -- Add git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
		},
	},

	{ -- Highlight todo, notes, etc in comments
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	{ -- Pretty list for diagnostics and other errors
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
		config = function()
			local map = function(keys, func, desc)
				vim.keymap.set("n", keys, func, { desc = "Trouble: " .. desc })
			end
			local trouble = require("trouble")
			-- Keymaps for panel
			map("<leader>xx", trouble.toggle, "Toggle panel")
			map("<leader>xw", function()
				trouble.toggle("workspace_diagnostics")
			end, "[w]orkspace diagnostics")
			map("<leader>xd", function()
				trouble.toggle("document_diagnostics")
			end, "[d]ocument diagnostics")
			map("<leader>xq", function()
				trouble.toggle("quickfix")
			end, "[q]uickfix list")
		end,
	},

	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "bash", "html", "lua", "markdown", "vim", "vimdoc", "go" },
				-- Autoinstall languages that are not installed
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{ "j-hui/fidget.nvim", opts = {} },

	-- Autoload all plugins from `lua/custom/plugins` directory
	-- Doing this allows these to be less stable and break, without bricking the whole init.lua setup
	-- (only that single lua import would fail and report its failings)
	{ import = "custom.plugins" },
}

-- lazy.nvim setup options
require("lazy").setup(plugins, {
	change_detection = {
		enabled = true,
		notify = false,
	},
})
