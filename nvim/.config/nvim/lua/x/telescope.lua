local ts_builtins = require('telescope.builtin')
require('mason').setup()
require('mason-lspconfig').setup()

-- Telescope setup
require('telescope').setup({
    defaults = {
        file_ignore_patterns = {
            "node_modules",
            "vendor"
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

vim.keymap.set("n", "<C-p>", function() ts_builtins.find_files() end)
vim.keymap.set("n",
    "<Leader><C-p>",
    function()
        local opts = require('telescope.themes').get_dropdown()
        opts.hidden = true
        opts.sorting_strategy = "descending"
        require('telescope').extensions.file_browser.file_browser(opts)
    end)
vim.keymap.set("n", "<Leader><Tab>",
    function()
        local opts = require('telescope.themes').get_dropdown()
        opts.hidden = true
        opts.sorting_strategy = "descending"
        ts_builtins.buffers()
    end)
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
