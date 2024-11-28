return {
	-- the official copilot plugin is quite slow, so we try out a lua rewrite
	-- "github/copilot.vim",
	-- -- Only load this plugin when <cmd>StartCopilot</cmd> is called
	-- config = function()
	-- 	-- Example for how to keymap accept command
	-- 	-- vim.keymap.set("i", "<C->", 'copilot#Accept("\\<CR>")', {
	-- 	-- 	expr = true,
	-- 	-- 	replace_keycodes = false,
	-- 	-- })
	-- 	-- Example to disable default Tab mapping
	-- 	-- vim.g.copilot_no_tab_map = true
	-- 	-- vim.cmd("Copilot disable")
	-- end,
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			panel = {
				enabled = true,
				auto_refresh = true,
				keymap = {
					jump_prev = "[[",
					jump_next = "]]",
					accept = "<CR>",
					refresh = "gr",
					open = "<M-CR>",
				},
				layout = {
					position = "bottom", -- | top | left | right
					ratio = 0.2,
				},
			},
			suggestion = {
				enabled = true,
				auto_trigger = true,
				hide_during_completion = true,
				debounce = 75,
				keymap = {
					accept = "<C-t>",
					accept_word = false,
					accept_line = false,
					next = "<C-]>",
					prev = "<C-[>",
					dismiss = "<Esc>",
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
			copilot_node_command = "node", -- Node.js version must be > 18.x
			server_opts_overrides = {},
		})
	end,
}
