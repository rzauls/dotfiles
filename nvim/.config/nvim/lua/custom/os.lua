if vim.fn.exists("g:os") == 0 then
	local is_windows = vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 or vim.fn.has("win16") == 1
	if is_windows then
		-- set shell=powershell
		-- set shellcmdflag=-command
		-- set shellquote=\"
		-- set shellxquote=
		vim.o.shell = "powershell"
		vim.o.shellcmdflag = "-command"
		vim.o.shellquote = "\\"
		vim.o.shellxquote = ""
	end
end
