-- LSP setup
local ts_builtins = require('x.telescope')
-- local capabilities = require('x.cmp')
-- Diagnostic keybinds
-- go to next highlighted error/warning
vim.keymap.set("n", "g]", vim.diagnostic.goto_next, { buffer = vim.nvim_get_current_buf })
-- go to previous highlighted error/warning
vim.keymap.set("n", "g[", vim.diagnostic.goto_prev, { buffer = vim.nvim_get_current_buf })
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

-- Show diagnostic popup on cursor hover
--
-- TODO: this thing kinda breaks when there are errors in the code
--   but you can just double K to jump into the lsp hover modal
vim.opt.updatetime = 100
local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
    end,
    group = diag_float_grp,
})

local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.nvim_workspace()

lsp.set_preferences({
    set_lsp_keymaps = false
})

lsp.on_attach(function(_, bufnr)
    local opts = { buffer = bufnr, remap = false }
    local remap = vim.keymap.set

    remap('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    -- show hover
    remap("n", "K", vim.lsp.buf.hover, { buffer = 0 })
    -- go to definition
    remap("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
    -- go to type definition
    remap("n", "gt", vim.lsp.buf.type_definition, { buffer = 0 })
    -- go to implementation
    remap("n", "gi", vim.lsp.buf.implementation, { buffer = 0 })
    -- rename symbol
    remap("n", "<F6>", vim.lsp.buf.rename, { buffer = 0 })
    -- format buffer with lsp-defined formatter
    remap("n", "<leader><A-f>", vim.lsp.buf.format, { buffer = 0 })
    -- list code actions (organize imports, etc)
    remap("n", "ga", vim.lsp.buf.code_action, { buffer = 0 })
end)

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
lsp.setup_nvim_cmp({
    mapping = lsp.defaults.cmp_mappings({
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    })
})

local rust_lsp = lsp.build_options('rust_analyzer', {})
require('rust-tools').setup({server = rust_lsp})

-- TODO: set up jose-elias-alvarez/typescrip.nvim for better ts experience
-- require("typescript").setup({
--     disable_commands = false, -- prevent the plugin from creating Vim commands
--     debug = false, -- enable debug logging for commands
--     go_to_source_definition = {
--         fallback = true, -- fall back to standard LSP definition on failure
--     },
--     server = { -- pass options to lspconfig's setup method
--         on_attach = ...,
--     },
-- })

lsp.setup()
