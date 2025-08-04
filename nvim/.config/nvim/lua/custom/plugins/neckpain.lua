return { 
	"shortcuts/no-neck-pain.nvim",
	version = "*",
	config = function() 
		local neckpain = require("no-neck-pain")

		vim.keymap.set("n", "<C-w>t", function()
			vim.cmd("NoNeckPain")
		end, { desc = "Toggle centered layout" })

		vim.keymap.set("n", "<C-w>r", function()
			vim.cmd("NoNeckPainScratchPad")
		end, { desc = "Toggle scratch pads whilst in centered layout" })

		neckpain.setup({
			width = 120,
			buffers = {
				scratchPad = {
					-- When `true`, automatically sets the following options to the side buffers:
					-- - `autowriteall`
					-- - `autoread`.
					---@type boolean
					enabled = false,
					-- The path to the file to save the scratchPad content to and load it in the buffer.
					---@type string?
					---@example: `~/notes.norg`
					pathToFile = "~/projects/notes/todo.md",
				}
			}
		})
	end
}
