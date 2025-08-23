-- Unsorted plugins
vim.opt.laststatus = 2
return {
	{ "milisims/nvim-luaref",        event = "VeryLazy" },           -- Lua help in :help
	{ "tpope/vim-sleuth",            event = "VeryLazy" },           -- Detect tabstop and shiftwidth automatically
	{ "j-hui/fidget.nvim",           event = "VeryLazy", opts = {} }, -- Loaders/progress bars
	{ "dzirtusss/netrw_keepdir_fix", event = "VeryLazy" },           -- Fix netrw 'mc' on mac
	{                                                                -- Code navigation helper
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{ "S",     mode = { "n", "x", "o" }, function() require("flash").jump() end,   desc = "flash.nvim - [S]earch/jump" },
			{ "<c-s>", mode = { "c" },           function() require("flash").toggle() end, desc = "flash.nvim - cancel search" },
		},
	},
	{ -- Todo/fixme highlighter
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{                   -- Keymap helper
		"folke/which-key.nvim",
		event = "VeryLazy", -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
			require("which-key").setup({
				notify = false,
			})
			require("which-key").add({
				{ "<leader>c", group = "[c]ode" },
				{ "<leader>d", group = "[d]ocument" },
				{ "<leader>r", group = "[r]ename" },
				{ "<leader>s", group = "[s]earch" },
				{ "<leader>w", group = "[w]orkspace" },
			})
		end,
	},
	{ -- Treesitter parsers
		"nvim-treesitter/nvim-treesitter",
		event = "VeryLazy",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"html",
					"lua",
					"markdown",
					"markdown_inline",
					"vim",
					"vimdoc",
					"go",
					"typescript",
					"javascript",
					"html",
					"css",
				},
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{ -- Filesystem navigation
		"stevearc/oil.nvim",
		event = "VeryLazy",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		config = function()
			require("oil").setup({
				view_options = {
					show_hidden = true,
				},
			})
			vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "[O]il up the parent directory" })
			vim.keymap.set("n", "<c-e>", "<CMD>Oil<CR>", { desc = "[O]il up the parent directory" })
		end,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	}
}
