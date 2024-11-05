-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [d]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [d]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [e]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier to remember
-- NOTE: This won't work in all terminal emulators/tmux/etc.
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Netrw and file navigation
vim.keymap.set("n", "<C-e>", function()
	vim.cmd("Explore")
end, { desc = "Open file [e]xplorer" })

vim.keymap.set("n", "<leader>so", function()
	return vim.cmd("ObsidianQuickSwitch")
end, { desc = "[s]earch [o]bsidian files" })

vim.keymap.set("n", "<leader>sm", function()
	return vim.cmd("ObsidianDailies")
end, { desc = "[s]earch [m]obsidian dailies" })

vim.keymap.set("n", "<leader>no", function()
	return vim.cmd("ObsidianNew")
end, { desc = "[n]ew obsidian entry" })

-- doesnt need to return anything for now
return {}
