require('nvim-treesitter.configs').setup({
    highlight = {
        enable = true
    },
    autotag = {
        enable = true,
        filetypes = {
            'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx',
            'rescript', 'xml', 'php', 'markdown', 'glimmer', 'handlebars', 'hbs', 'blade'
        }
    }
})
-- LSP setup
local ts_builtins = require('x.telescope')
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

lsp.set_preferences({
    set_lsp_keymaps = false
})

lsp.on_attach(function(_, bufnr)
    local opts = { buffer = bufnr, remap = false }
    local remap = vim.keymap.set
    local buffer_functions = vim.lsp.buf

    remap('n', '<leader>r', '<cmd>lua buffer_functions.rename()<cr>', opts)
    -- show hover
    remap("n", "K", buffer_functions.hover, { buffer = 0 })
    -- go to definitio
    remap("n", "gd", buffer_functions.definition, { buffer = 0 })
    -- go to type definition
    remap("n", "gt", buffer_functions.type_definition, { buffer = 0 })
    -- go to implementation
    remap("n", "gi", buffer_functions.implementation, { buffer = 0 })
    -- show usages
    remap("n", "gu", buffer_functions.references, { buffer = 0 })
    -- rename symbol
    remap("n", "<leader>rn", buffer_functions.rename, { buffer = 0 })
    -- format buffer with lsp-defined formatter
    remap({ "n", "v" }, "<leader><A-f>", buffer_functions.format, { buffer = 0 })
    -- list code actions (organize imports, etc)
    remap("n", "ga", buffer_functions.code_action, { buffer = 0 })
end)

local cmp = require('cmp')
local luasnip = require('luasnip')
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
    mapping = lsp.defaults.cmp_mappings({
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<Tab>"] = cmp.mapping(function(fallback)         -- smart "forward" in snippet
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback) -- smart "back" in snippet
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<C-j>"] = cmp.mapping(function(fallback) -- cycle through choices
            if luasnip.choice_active() then
                luasnip.change_choice(1)
            else
                fallback()
            end
        end)
    })
})

local servers = {
    'rust_analyzer',
    'gopls',
    'tsserver',
    'lua_ls'
}
lsp.setup_servers(servers);

lsp.setup()
