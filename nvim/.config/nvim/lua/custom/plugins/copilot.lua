local plugins = {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "VeryLazy",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = false,
					auto_refresh = false,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
						open = "<M-CR>",
					},
					layout = {
						position = "bottom", -- | top | left | right | horizontal | vertical
						ratio = 0.4,
					},
				},
				suggestion = {
					enabled = true,
					auto_trigger = true,
					hide_during_completion = true,
					debounce = 75,
					keymap = {
						accept = "<D-Y>",
						accept_word = false,
						accept_line = false,
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
				filetypes = {
					yaml = false,
					markdown = false,
					help = false,
					gitcommit = false,
					gitrebase = false,
					hgcommit = false,
					svn = false,
					cvs = false,
					["."] = false,
				},
				logger = {
					print_log = false,
					print_log_level = vim.log.levels.ERROR,
				},
				copilot_node_command = "node", -- Node.js version must be > 18.x
				server_opts_overrides = {},
			})
		end,
	},
}

-- chat is broken on windows so we dont load even bother
if not require("custom.util").is_windows then
	-- hide copilot suggestions when blink.cmp menu is open
	vim.api.nvim_create_autocmd("User", {
		pattern = "BlinkCmpMenuOpen",
		callback = function()
			vim.b.copilot_suggestion_hidden = true
		end,
	})

	vim.api.nvim_create_autocmd("User", {
		pattern = "BlinkCmpMenuClose",
		callback = function()
			vim.b.copilot_suggestion_hidden = false
		end,
	})

	table.insert(plugins, {
		"CopilotC-Nvim/CopilotChat.nvim",
		event = "VeryLazy",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {},
	})
end

return plugins
