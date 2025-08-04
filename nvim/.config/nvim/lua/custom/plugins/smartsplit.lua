function resize_split_to_two_thirds()
	local width = vim.o.columns
	local target_width = math.floor(width * 2 / 3)

	local current_width = vim.api.nvim_win_get_width(0)
	local amount = target_width - current_width

	if amount > 0 then
		vim.cmd("vertical resize +" .. amount)
	else
		vim.cmd("vertical resize " .. target_width)
	end
end

vim.api.nvim_create_user_command("ResizeSplitToTwoThirds", resize_split_to_two_thirds, {})

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

		vim.keymap.set("n", "<C-w>r", function()
			vim.cmd("ResizeSplitToTwoThirds")
		end, { desc = "Resize split to 2/3" })
	end,
}
