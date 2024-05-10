return {
	"willothy/wezterm.nvim",
	lazy = false,
	config = function()
		local wezterm = require("wezterm")
		local vim_navigate = function(direction)
			if direction == "n" then
				pcall(vim.cmd, "wincmd w")
			elseif pcall(vim.cmd, "wincmd " .. direction) then
			-- success
			else
				-- error, cannot wincmd from the command-line window
				vim.cmd(
					[[ echohl ErrorMsg | echo 'E11: Invalid in command-line window; <CR> executes, CTRL-C quits' | echohl None ]]
				)
			end
		end

		local wezterm_control = true

		local navigate = function(direction)
			-- save the current window number to check later whether we're in the same
			-- window after issuing a vim navigation command
			local winnr = vim.fn.winnr()

			-- try to navigate normally
			vim_navigate(direction)

			-- if we're in the same window after navigating
			local is_same_winnr = (winnr == vim.fn.winnr())
			P(is_same_winnr)

			-- if we're in the same window and zoom is not disabled, tmux should take control
			if is_same_winnr then
				P("should wezterm move")
				if direction == "h" then
					wezterm.switch_pane.direction("Left")
				end

				if direction == "j" then
					wezterm.switch_pane.direction("Down")
				end

				if direction == "k" then
					wezterm.switch_pane.direction("Up")
				end

				if direction == "l" then
					wezterm.switch_pane.direction("Right")
				end
			end
		end

		vim.keymap.set("n", "<C-h>", function()
			navigate("h")
		end, { desc = "Move focus to the left window" })
		vim.keymap.set("n", "<C-j>", function()
			navigate("j")
		end, { desc = "Move focus to the down window" })
		vim.keymap.set("n", "<C-k>", function()
			navigate("k")
		end, { desc = "Move focus to the up window" })
		vim.keymap.set("n", "<C-l>", function()
			navigate("l")
		end, { desc = "Move focus to the right window" })
	end,
}
