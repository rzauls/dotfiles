-- main config
require('x.util') -- helper functions to debug config development
require('x.opts') -- global options
require('x.plugins') -- packer and plugin list
require('x.theme')
require('x.telescope') -- telescope config
require('x.lsp') -- lsp config
require('x.debug') -- debugger/dap config
require('x.misc_configs') -- short configs that dont fit anywhere else
require('x.keymap') -- non-specific keymaps
require('x.commands') -- custom commands
require('x.terminal') -- inbuilt terminal related configuration
require('snippets.all') -- luasnip snippet dump, probably needs to be loaded elsewhere
