local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "

local plugins = {
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "nvim-lua/plenary.nvim" },
    -- telescope/system plugins
    { 'nvim-treesitter/nvim-treesitter',           build = function() vim.fn['TSUpdate']() end },
    { 'nvim-treesitter/playground' },
    { 'nvim-telescope/telescope.nvim',             tag = '0.1.0' },
    { 'nvim-telescope/telescope-file-browser.nvim' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim',  build = 'make' },
    {
        'VonHeikemen/lsp-zero.nvim',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    },
    -- language specific improvements
    { 'simrat39/rust-tools.nvim' },
    { 'jose-elias-alvarez/typescript.nvim' },
    { 'jwalton512/vim-blade' },
    { 'ray-x/go.nvim' },
    { 'ray-x/guihua.lua' },
    -- debugging
    { 'mfussenegger/nvim-dap' },
    { 'rcarriga/nvim-dap-ui' },
    { 'theHamsta/nvim-dap-virtual-text' },
    { 'nvim-telescope/telescope-dap.nvim' },
    { 'leoluz/nvim-dap-go' },
    -- auto brackets and xml tags
    { 'windwp/nvim-autopairs' },  -- bracket pairs
    { 'windwp/nvim-ts-autotag' }, -- html auto pairs
    { 'tpope/vim-surround' },     -- surrounding things with other things
    -- less shit code folding
    {
        'kevinhwang91/nvim-ufo',
        dependencies = {
            { 'kevinhwang91/promise-async' }
        }
    },
    -- decorative fluff
    { "rcarriga/nvim-notify" },
    { "catppuccin/nvim",                    name = "catppuccin" }, -- mocha (the darkest variant)
    { 'kyazdani42/nvim-web-devicons' },                            --icons
    { 'lukas-reineke/indent-blankline.nvim' },                     --display indents
    { 'lewis6991/gitsigns.nvim' },
    { 'nvim-lualine/lualine.nvim' },
    -- pseudo-productivity
    { 'numToStr/Comment.nvim' }, --comment helper
    { 'kdheepak/lazygit.vim' },  --lazygit inside vim
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        ft = { "markdown" }
    }
}
require("lazy").setup(plugins, {
    defaults = { lazy = false }
})
