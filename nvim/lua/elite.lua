local action_state = require('telescope.actions.state') -- load lua library
local opts = require('telescope.themes').get_dropdown({ winblend = 10 }) -- set theme override for the telescope calls
local builtins = require('telescope.builtin')

-- Telescope setup
require('telescope').setup {
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

-- Autocomplete keybinds and logic
local cmp = require('cmp')
vim.opt.completeopt = { "menu", "menuone", "noselect" }
cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
    }, {
        { name = 'buffer' },
    })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = 'buffer' },
    })
})

-- capabilities to configure LSP integration with autocomplete
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- LSP setup
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
    vim.keymap.set("n", "<leader>dl", builtins.diagnostics, { buffer = 0 })
    -- rename symbol
    vim.keymap.set("n", "<F6>", vim.lsp.buf.rename, { buffer = 0 })
    -- format buffer with lsp-defined formatter
    vim.keymap.set("n", "<leader><A-f>", vim.lsp.buf.format, { buffer = 0 })
    -- list code actions (organize imports, etc)
    vim.keymap.set("n", "<leader><C-Enter>", vim.lsp.buf.code_action, { buffer = 0 })
end
-- Language specific settings
-- Lua
require('lspconfig').sumneko_lua.setup {
    on_attach = function()
        generic_lsp_keybinds()
    end,
    capabilities = capabilities,
}
-- Go
require('lspconfig').gopls.setup {
    on_attach = function()
        generic_lsp_keybinds()
    end,
    capabilities = capabilities,
}
-- Rust
require('lspconfig').rust_analyzer.setup{
    on_attach = function()
        generic_lsp_keybinds()
    end,
    capabilities = capabilities,
}

-- TODO:
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
