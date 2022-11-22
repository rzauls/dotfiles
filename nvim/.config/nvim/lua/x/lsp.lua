-- LSP setup
local ts_builtins = require('x.telescope')
local capabilities = require('x.cmp')
-- Generic keybinds that work for most language servers
local generic_lsp_keybinds = function()
    -- peek definition
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
    -- go to definition
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
    -- go to type definition
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = 0 })
    -- go to implementation
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0 })
    -- go to next highlighted error/warning
    vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, { buffer = 0 })
    -- go to previous highlighted error/warning
    vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, { buffer = 0 })
    -- list diagnostics with fuzzy search
    vim.keymap.set(
        "n",
        "<leader>dl",
        function()
            local opts = require('telescope.themes').get_dropdown()
            opts.buffer = 0
            ts_builtins.diagnostics(opts)
        end
    )
    -- rename symbol
    vim.keymap.set("n", "<F6>", vim.lsp.buf.rename, { buffer = 0 })
    -- format buffer with lsp-defined formatter
    vim.keymap.set("n", "<leader><A-f>", vim.lsp.buf.format, { buffer = 0 })
    -- list code actions (organize imports, etc)
    vim.keymap.set("n", "<leader><C-Enter>", vim.lsp.buf.code_action, { buffer = 0 })
end
-- Language specific settings
-- Lua
require('lspconfig').sumneko_lua.setup({
    on_attach = function() generic_lsp_keybinds() end,
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                -- assume 'vim' is available to suppress misleading diagnostics
                globals = {
                    'vim',
                    'awesome',
                    'client',
                    'root',
                }
            }
        }
    }
})

-- Go
require('lspconfig').gopls.setup({
    on_attach = function() generic_lsp_keybinds() end,
    capabilities = capabilities,
})
-- Rust
-- rust-tools calls lspconfig.setup() under the hood
require('rust-tools').setup({
    server = {
        on_attach = function(_, bufnr)
            generic_lsp_keybinds()
            vim.keymap.set("n", "<F10>", "<cmd>!cargo run <cr>", { buffer = bufnr })
            -- vim.keymap.del("n", "<leader><A-f>") -- use rustfmt, since rust-analyzer does not provide formatting
            -- vim.keymap.set("n", "<leader><A-f>", require('rust-tools')., { buffer = 0 })
        end,
        capabilities = capabilities
    }
})
-- TypeScript/JavaScript
-- TODO: needs refinement
require('lspconfig').tsserver.setup({
    on_attach = function() generic_lsp_keybinds() end,
    capabilities = capabilities,
})
-- PHP
require('lspconfig').intelephense.setup({
    on_attach = function(_, bufnr)
        generic_lsp_keybinds()
            vim.keymap.set("n", "<F10>", "<cmd>!cargo run <cr>", { buffer = bufnr })
    end,
    capabilities = capabilities,

})
-- TODO:
-- Elixir






return {}
