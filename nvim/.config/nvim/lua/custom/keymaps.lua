-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [d]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [d]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [e]rror messages" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.setloclist, { desc = "Show buffer diagnostics in [q]uickfix list" })

-- I like deleting buffers
vim.keymap.set("n", "<leader>q", "<cmd>bd<cr>", { desc = "Close current buffer" })

-- Netrw and file navigation
vim.keymap.set("n", "<C-e>", function()
	vim.cmd("Explore")
end, { desc = "Open file [e]xplorer" })

-- Less insane way of exiting terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Tmux session wrangler
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

return {}
