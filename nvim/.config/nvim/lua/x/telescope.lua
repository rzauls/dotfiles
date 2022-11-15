local ts_builtins = require('telescope.builtin')

-- Telescope setup
require('telescope').setup()
require('telescope').load_extension('fzf')
require('telescope').load_extension('file_browser')

local theme_opts = require('telescope.themes').get_dropdown() -- set theme override for the telescope calls
-- ts_builtins.find_files({ hidden = true, opts })
-- ts_builtins.current_buffer_fuzzy_find(opts, { buffer = f })

vim.keymap.set("n", "<C-p>", function() ts_builtins.find_files({ theme_opts }) end)
vim.keymap.set("n", "<Leader><Tab>", function() ts_builtins.buffers({ theme_opts }) end)
vim.keymap.set("n", "<Leader>ff", function() ts_builtins.current_buffer_fuzzy_find({ theme_opts }) end)

return ts_builtins
