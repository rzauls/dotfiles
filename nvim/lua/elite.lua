local action_state = require('telescope.actions.state') -- load lua library
local opts = require('telescope.themes').get_dropdown({winblend=10}) -- set theme override for the telescope calls
local builtins = require('telescope.builtin')

-- Telescope setup
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
-- load Telescope extensions
require('telescope').load_extension('fzf')
require('telescope').load_extension('file_browser')

-- LSP setup
-- Lua
require('lspconfig').sumneko_lua.setup{}
-- Go
require('lspconfig').gopls.setup{
    on_attach = function ()
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0}) -- peak definition
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0}) -- go to definition
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer=0}) -- go to definition
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer=0}) -- go to definition
        vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, {buffer=0}) -- go to definition
        vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, {buffer=0}) -- go to definition
        vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", {buffer=0})
    end,
}


-- TODO:
-- Rust
-- Elixir
-- PHP
-- JS/TS

-- Exported keybind functions (used in init.vim)
local exported_mappings = {
    -- switch buffers
    buffers = function()
        builtins.buffers(opts)
    end,
    -- find files in cwd
    find_files = function() -- find files in cwd
        builtins.find_files(opts)
    end,
    -- fuzzy find in current buffer
    current_buffer_fuzzy_find = function() 
        builtins.current_buffer_fuzzy_find(opts)
    end,
}
return exported_mappings
