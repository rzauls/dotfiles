local action_state = require('telescope.actions.state') -- load lua library
-- initialize telescope
require('telescope').setup{
    defaults = {
        prompt_prefix = "> ",
        mappings = {
            -- insert mode mappings
            i = { 
                ["<c-a>"] = function() print(vim.inspect(action_state.get_selected_entry())) end
            }
        }
    }
}
-- load telescope extensions
require('telescope').load_extension('fzf')
require('telescope').load_extension('file_browser')

