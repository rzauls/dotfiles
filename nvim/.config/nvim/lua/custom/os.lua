if vim.fn.exists("g:os") == 0 then
	if require("custom.util").is_windows then
		vim.o.shell = "powershell"
		vim.o.shellcmdflag = "-command"
		vim.o.shellquote = "\\"
		vim.o.shellxquote = ""
	end
end
