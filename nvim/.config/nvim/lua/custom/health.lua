local check_version = function()
	local verstr = string.format("%s.%s.%s", vim.version().major, vim.version().minor, vim.version().patch)
	if not vim.version.cmp then
		vim.health.error(string.format("Neovim out of date: '%s'. Upgrade to latest stable or nightly", verstr))
		return
	end

	if vim.version.cmp(vim.version(), { 0, 10, 1 }) >= 0 then
		vim.health.ok(string.format("Neovim version is: '%s'", verstr))
	else
		vim.health.error(string.format("Neovim out of date: '%s'. Upgrade to latest stable or nightly", verstr))
	end
end

local check_external_reqs = function()
	for _, exe in ipairs({
		"git",
		"make",
		"unzip",
		"rg",
		"fzf",
		"fd",
		"curl",
	}) do
		local is_executable = vim.fn.executable(exe) == 1
		if is_executable then
			vim.health.ok(string.format("Found executable: '%s'", exe))
		else
			vim.health.warn(string.format("Could not find executable: '%s'", exe))
		end
	end

	return true
end

local check_env_vars = function()
	if os.getenv("DOTFILES_PATH") == nil then
		vim.health.warn(string.format("DOTFILES_PATH is not set, not all configuration files will be searchable"))
	end

	if os.getenv("TODO_NOTE_FILE") == nil then
		vim.health.warn(
			string.format(
				"TODO_NOTE_FILE is not set, will create it in default location ('~/notes.md') on next 'open notes' invocation"
			)
		)
	end
end

return {
	check = function()
		vim.health.start("custom.nvim")

		local uv = vim.uv or vim.loop
		vim.health.info("System Information: " .. vim.inspect(uv.os_uname()))

		check_version()
		check_external_reqs()
		check_env_vars()
	end,
}
