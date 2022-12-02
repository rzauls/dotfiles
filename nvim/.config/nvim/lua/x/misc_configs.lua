require('gitlinker').setup({
    -- generate link with specific line
    mappings = "<leader>gy"
})

require('indent_blankline').setup()
require('nvim-autopairs').setup()
require('Comment').setup()
require('gitsigns').setup()


-- filetree stuff
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- empty setup using defaults
require("nvim-tree").setup()
