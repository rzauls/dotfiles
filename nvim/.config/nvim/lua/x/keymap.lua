-- various random keybinds that dont fit in any other configuratio files currently
-- TODO: map movement between buffers better
vim.keymap.set("n", "<Leader>h", "<cmd>bprev<cr>") -- cycle to previous buffer

vim.keymap.set("n", "<C-d>", "<C-d>zz") -- ccenter view when scrolling by half page
vim.keymap.set("n", "<C-u>", "<C-u>zz") -- center view when scrolling by half page

vim.keymap.set("n", "<leader><C-w>", "<cmd>bd<cr>") -- close buffer

-- TODO: learn how quickfix list could be used more in daily stuff
vim.keymap.set("n", "<leader>co", "<cmd>copen<cr>") -- previous qf item
vim.keymap.set("n", "<leader>cc", "<cmd>cclose<cr>") -- previous qf item
vim.keymap.set("n", "<leader>[", "<cmd>cprev<cr>") -- previous qf item
vim.keymap.set("n", "<leader>]", "<cmd>cnext<cr>") -- previous qf item
vim.keymap.set("n", "<leader>da", vim.diagnostic.setqflist)
