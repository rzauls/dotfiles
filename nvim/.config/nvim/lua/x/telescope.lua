local ts_builtins = require('telescope.builtin')

-- Telescope setup
require('telescope').setup()
require('telescope').load_extension('fzf')
require('telescope').load_extension('file_browser')

-- ts_builtins.current_buffer_fuzzy_find(opts, { buffer = f })

vim.keymap.set("n", "<C-p>", function() ts_builtins.find_files({ hidden = true }) end)
vim.keymap.set("n",
    "<Leader><C-p>",
    function()
        local opts = require('telescope.themes').get_dropdown()
        opts.hidden = true
        require('telescope').extensions.file_browser.file_browser(opts)
    end)
vim.keymap.set("n", "<Leader><Tab>", function() ts_builtins.buffers() end)
vim.keymap.set("n", "<Leader><Up>", function() ts_builtins.command_history() end)
vim.keymap.set(
    "n",
    "<Leader>ff",
    function()
        local opts = require('telescope.themes').get_dropdown()
        opts.buffer = 0
        opts.sorting_strategy = "descending"
        ts_builtins.current_buffer_fuzzy_find(opts)
    end)

-- TODO: figure out a good keybind for other builtins

return ts_builtins
