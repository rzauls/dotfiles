vim.o.background = 'dark'
vim.o.termguicolors = true

require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = {
        light = "latte",
        dark = "mocha",
    },
    compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
})

vim.cmd({ cmd = "colorscheme", args = { 'catppuccin' } })
-- status line
require('lualine').setup({
    options = {
        theme = 'catppuccin'
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
