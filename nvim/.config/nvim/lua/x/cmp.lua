local luasnip = require('luasnip')
luasnip.config.set_config({
    history = true,
    updateEvents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
})

vim.keymap.set({"i", "s"}, "<Tab>", function()
    if luasnip.jumpable(1) then
        luasnip.jump(1)
    end
end)
vim.keymap.set({"i", "s"}, "<S-Tab>", function()
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    end
end)

vim.keymap.set({"i", "s"}, "<A-j>", function()
    if luasnip.choice_actice() then
        luasnip.change_choice(1)
    end
end)
vim.keymap.set({"i", "s"}, "<A-k>", function()
    if luasnip.choice_actice() then
        luasnip.change_choice(-1)
    end
end)
-- TODO: fix auto-loading custom snippets
-- require('luasnip.loaders.from_lua').load({ paths = "~/.config/nvim/lua/snippets"})
--
-- TODO: fix loading custom snippets
local s = luasnip.snippet
local t = luasnip.text_node
luasnip.add_snippets("all", {
    s("snipsnip", {t("testing text snippet for all filetypes")})
})

-- Autocomplete keybinds and setup
local cmp = require('cmp')
vim.opt.spelllang = { 'en' }
vim.opt.completeopt = { "menu", "menuone", "noselect" }
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
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
        { name = 'nvim_lua' },
        { name = 'luasnip' },
        {
            name = 'spell',
            option = {
                keep_all_entries = false,
                enable_in_context = function()
                    return require('cmp.config.context').in_treesitter_capture('spell')
                end,
            }
        }
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



return require('cmp_nvim_lsp').default_capabilities()
