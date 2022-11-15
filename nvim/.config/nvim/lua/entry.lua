-- main config
require('x.util') -- helper functions to debug config development
require('x.plugins') -- packer and plugin list
require('x.telescope') -- telescope config
require('x.cmp') -- autocomplete/cmp config
require('x.lsp') -- lsp config
require('x.debug') -- debugger/dap config
require('x.misc_configs') -- short configs that dont fit anywhere else

vim.keymap.set("n", "<Leader>h", "<cmd>bprev<cr>") -- previous buffer
vim.keymap.set("n", "<Leader>l", "<cmd>bnext<cr>") -- next buffer

