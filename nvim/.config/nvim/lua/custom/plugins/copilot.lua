local plugins = {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = false,
				},
				suggestion = {
					enabled = true,
					keymap = {
						accept = "<M-l>",
						accept_word = false,
						accept_line = false,
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
			})
		end,
	},
}

-- chat is broken on windows so we dont even bother loading it
if not require("custom.util").is_windows then
	vim.keymap.set("n", "<leader>cc", function()
		return vim.cmd("CopilotChat")
	end, { desc = "[c]opilot [c]hat" })

	table.insert(plugins, {
		"CopilotC-Nvim/CopilotChat.nvim",
		event = "InsertEnter",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {},
	})
end

-- TODO: remove this if we end up staying on copilot suggestions inside blink.cmp
--
-- hide copilot suggestions when blink.cmp menu is open
-- vim.api.nvim_create_autocmd("User", {
-- 	pattern = "BlinkCmpMenuOpen",
-- 	callback = function()
-- 		vim.b.copilot_suggestion_hidden = true
-- 	end,
-- })
--
-- vim.api.nvim_create_autocmd("User", {
-- 	pattern = "BlinkCmpMenuClose",
-- 	callback = function()
-- 		vim.b.copilot_suggestion_hidden = false
-- 	end,
-- })

return plugins
