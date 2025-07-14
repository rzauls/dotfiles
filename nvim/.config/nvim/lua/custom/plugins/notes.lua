local note_file = os.getenv("TODO_NOTE_FILE")
if note_file == nil then
	note_file = "~/notes.md"
end

vim.keymap.set("n", "<leader>oo", function()
	return vim.cmd("e " .. note_file)
end, { desc = "[o]pen [o] notes.md file" })

-- TODO: create a keybind to open notes search

return {}
