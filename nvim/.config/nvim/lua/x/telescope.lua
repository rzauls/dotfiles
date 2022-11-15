local action_state = require('telescope.actions.state')
local ts_builtins = require('telescope.builtin')

-- Telescope setup
require('telescope').setup({
    defaults = {
        prompt_prefix = "> ",
        mappings = {
            -- insert mode mappings while in telescope prompt
            i = {
                ["<c-a>"] = function() print(vim.inspect(action_state.get_selected_entry())) end
            }
        }
    }
})
-- Load Telescope extensions
require('telescope').load_extension('fzf')
require('telescope').load_extension('file_browser')

return ts_builtins


