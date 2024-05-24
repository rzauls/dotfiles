-- Pretty list for diagnostics and other errors
return {
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
}
