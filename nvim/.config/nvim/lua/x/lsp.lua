-- LSP setup
local ts_builtins = require('x.telescope')
local capabilities = require('x.cmp')
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
vim.opt.updatetime = 100
local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
   vim.diagnostic.open_float(nil, { focusable = false })
  end,
  group = diag_float_grp,
})
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
    -- rename symbol
    vim.keymap.set("n", "<F6>", vim.lsp.buf.rename, { buffer = 0 })
    -- format buffer with lsp-defined formatter
    vim.keymap.set("n", "<leader><A-f>", vim.lsp.buf.format, { buffer = 0 })
    -- list code actions (organize imports, etc)
    vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { buffer = 0 })
end
-- Language specific settings
-- Lua
require('lspconfig').sumneko_lua.setup({
    on_attach = function() generic_lsp_keybinds() end,
    capabilities = capabilities,
    settings = {
        Lua = {
            workspace = {
                useGitIgnore = true
            },
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
    on_attach = function(_, bufnr)
        generic_lsp_keybinds()
        -- TODO: this kinda doesnt work for most things but ok enough for little scripts
        vim.keymap.set("n", "<F10>", "<cmd>!go run main.go<cr>", { buffer = bufnr })
    end,
    capabilities = capabilities,
})
-- Rust
-- rust-tools calls lspconfig.setup() under the hood
require('rust-tools').setup({
    tools = {
        runnables = {
            use_telescope = true,
        }

    },
    server = {
        on_attach = function(_, bufnr)
            generic_lsp_keybinds()
            vim.keymap.set("n", "<F10>", "<cmd>!cargo run <cr>", { buffer = bufnr })
            -- vim.keymap.del("n", "<leader><A-f>") -- use rustfmt, since rust-analyzer does not provide formatting
            -- vim.keymap.set("n", "<leader><A-f>", require('rust-tools')., { buffer = 0 })
        end,
        capabilities = capabilities,
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                }
            }
        }
    }
})
-- TypeScript/JavaScript
require('lspconfig').tsserver.setup({
    on_attach = function() generic_lsp_keybinds() end,
    capabilities = capabilities,
})
-- PHP
-- i dont think the stubs actually do anything
require('lspconfig').intelephense.setup({
    settings = {
        intelephense = {
            stubs = {
                "bcmath", "bz2", "Core", "curl", "date", "dom",
                "fileinfo", "filter", "gd", "gettext", "hash",
                "iconv", "imap", "intl", "json", "libxml", "mbstring",
                "mcrypt", "mysql", "mysqli", "password", "pcntl",
                "pcre", "PDO", "pdo_mysql", "Phar", "readline", "regex",
                "session", "SimpleXML", "sockets", "sodium", "standard",
                "superglobals", "tokenizer", "xml", "xdebug", "xmlreader",
                "xmlwriter", "yaml", "zip", "zlib", "wordpress-stubs",
                "woocommerce-stubs", "acf-pro-stubs", "wordpress-globals",
                "wp-cli-stubs", "genesis-stubs", "polylang-stubs"
            },
            environment = {
                includePaths = { os.getenv("HOME") .. '/.composer/vendor/php-stubs/' }
            },
            files = {
                maxSize = 5000000;
            };
        }

    },
    on_attach = function(_, bufnr)
        generic_lsp_keybinds()
        vim.keymap.set("n", "<F10>", "<cmd>!php %<cr>", { buffer = bufnr })
    end,
    capabilities = capabilities,

})
require('lspconfig').marksman.setup({
    server = {
        on_attach = function()
            generic_lsp_keybinds()
            vim.opt.spell = true
        end,
        capabilities = capabilities,
    }
})


-- Python
-- TODO: prob needs some more configuration
require('lspconfig').pyright.setup({})
