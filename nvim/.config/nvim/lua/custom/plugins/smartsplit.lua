-- Split/pane management (with terminal mux support)
return {
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
		vim.keymap.set("n", "<C-A-h>", function()
			smartsplits.resize_left(10)
		end)
		vim.keymap.set("n", "<C-A-j>", smartsplits.resize_down)
		vim.keymap.set("n", "<C-A-k>", smartsplits.resize_up)
		vim.keymap.set("n", "<C-A-l>", function()
			smartsplits.resize_right(10)
		end)
		-- swap
		vim.keymap.set("n", "<leader><A-h>", smartsplits.swap_buf_left)
		vim.keymap.set("n", "<leader><A-j>", smartsplits.swap_buf_down)
		vim.keymap.set("n", "<leader><A-k>", smartsplits.swap_buf_up)
		vim.keymap.set("n", "<leader><A-l>", smartsplits.swap_buf_right)
	end,
}
