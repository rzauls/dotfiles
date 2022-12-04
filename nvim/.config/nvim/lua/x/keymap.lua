-- various random keybinds that dont fit in any other configuratio files currently
-- TODO: map movement between buffers better
vim.keymap.set("n", "<Leader>h", "<cmd>bprev<cr>") -- cycle to previous buffer

vim.keymap.set("n", "<C-d>", "<C-d>zz") -- ccenter view when scrolling by half page
vim.keymap.set("n", "<C-u>", "<C-u>zz") -- center view when scrolling by half page

vim.keymap.set("n", "<Leader><C-e>", "<cmd>NvimTreeToggle<cr>") --toggle file tree
--
-- TODO: figure out a vertical/horizontal split flow
-- TODO: map movements between splits to something reasonable
