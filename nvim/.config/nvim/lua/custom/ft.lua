local group = vim.api.nvim_create_augroup("Line Wrap Settings", { clear = true })

-- enable wrap for specific filetypes
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.md" },
	group = group,
	command = "setlocal wrap linebreak nolist",
})
