require('gitlinker').setup({
    -- generate link with specific line
    mappings = "<leader>gy"
})

require('indent_blankline').setup()
require('nvim-autopairs').setup()
require('Comment').setup()
require('gitsigns').setup()
-- status line
require('lualine').setup({
    options = {
        theme = 'gruvbox'
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'filetype' },
        lualine_y = {},
        lualine_z = { 'location' }
    },
})


