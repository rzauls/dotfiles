local ts_builtins = require('telescope.builtin')
require('mason').setup()
require('mason-lspconfig').setup()

-- Telescope setup
require('telescope').setup({
    defaults = {
        file_ignore_patterns = {
            "node_modules/",
            "vendor/",
            ".git/"
        }
    },
    extensions = {
        ["ui-select"] = {
            require('telescope.themes').get_dropdown()
        }
    }
})
require('telescope').load_extension('fzf')
require('telescope').load_extension('file_browser')
require('telescope').load_extension('ui-select')

-- ts_builtins.current_buffer_fuzzy_find(opts, { buffer = f })

vim.keymap.set("n", "<C-p>", function() ts_builtins.find_files({ hidden = true }) end)
vim.keymap.set("n", "<Leader><Leader>", function() ts_builtins.live_grep({ hidden = true }) end)
vim.keymap.set("n", "<Leader><Tab>", function() ts_builtins.buffers() end)
vim.keymap.set("n", "<Leader><Up>", function() ts_builtins.command_history() end)
vim.keymap.set(
    "n",
    "<Leader>ff",
    function()
        local opts = {
            buffer = 0,
            sorting_strategy = "descending"
        }
        ts_builtins.current_buffer_fuzzy_find(opts)
    end)

vim.keymap.set("n", "<F4>", function() ts_builtins.reloader() end)
-- TODO: figure out a good keybind for other builtins

return ts_builtins
