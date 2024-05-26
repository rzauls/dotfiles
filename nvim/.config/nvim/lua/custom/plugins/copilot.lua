return {
	"github/copilot.vim",
	-- Only load this plugin when <cmd>StartCopilot</cmd> is called
	cmd = "StartCopilot",
	config = function()
		-- Example for how to keymap accept command
		-- vim.keymap.set("i", "<C->", 'copilot#Accept("\\<CR>")', {
		-- 	expr = true,
		-- 	replace_keycodes = false,
		-- })
		-- Example to disable default Tab mapping
		-- vim.g.copilot_no_tab_map = true
		vim.cmd("Copilot disable")
	end,
}
