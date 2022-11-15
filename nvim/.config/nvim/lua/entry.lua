-- main config
local ts_builtins = require('x.telescope') -- telescope config
require('x.util.helpers') -- helper functions to debug config development
require('x.plugins') -- packer and plugin list
require('x.cmp') -- autocomplete/cmp config
require('x.lsp') -- lsp config
require('x.debug') -- debugger/dap config
require('x.misc_configs') -- short configs that dont fit anywhere else

-- Exported keybind functions
-- (currently no reason to do this, since we dont use them in init.vim anymore)
local opts = require('telescope.themes').get_dropdown({ winblend = 10 }) -- set theme override for the telescope calls
local exported_mappings = {
    -- switch buffers
    buffers = function()
        ts_builtins.buffers(opts)
    end,
    -- find files in cwd
    find_files = function() -- find files in cwd
        ts_builtins.find_files({ hidden = true, opts })
    end,
    -- fuzzy find in current buffer
    current_buffer_fuzzy_find = function()
        -- FIXME: this currently searches in the "previous" not current buffer for some reason
        ts_builtins.current_buffer_fuzzy_find(opts, { buffer = 0 })
    end,
}

-- Generic global keybinds
vim.keymap.set("n", "<C-p>", exported_mappings.find_files)
vim.keymap.set("n", "<Leader><Tab>", exported_mappings.buffers)
vim.keymap.set("n", "<Leader>ff", exported_mappings.current_buffer_fuzzy_find)
vim.keymap.set("n", "<Leader>h", "<cmd>bprev<cr>") -- previous buffer
vim.keymap.set("n", "<Leader>l", "<cmd>bnext<cr>") -- next buffer

return exported_mappings
