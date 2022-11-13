local action_state = require('telescope.actions.state') -- load lua library
-- initialize telescope
require('telescope').setup{
    defaults = {
        prompt_prefix = "> ",
        mappings = {
            -- insert mode mappings while in telescope prompt
            i = { 
                ["<c-a>"] = function() print(vim.inspect(action_state.get_selected_entry())) end
            }
        }
    }
}
-- load telescope extensions
require('telescope').load_extension('fzf')
require('telescope').load_extension('file_browser')

-- define some exported keybind functions
local mappings = {}
local opts = require('telescope.themes').get_dropdown() -- set theme override for the telescope calls
local builtins = require('telescope.builtin')

mappings.buffers = function() 
    builtins.buffers(opts)
end

mappings.find_files = function() 
    builtins.find_files(opts)
end

mappings.current_buffer_fuzzy_find = function()
    builtins.current_buffer_fuzzy_find(opts)
end

return mappings
