local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]


return require('packer').startup(function(use)
    use({ "wbthomason/packer.nvim" }) -- Packer can update itself
    use({ "williamboman/mason.nvim" })
    use({"williamboman/mason-lspconfig.nvim"})
    use({ "nvim-lua/plenary.nvim" }) -- Useful lua functions used by lots of plugins
    -- telescope/system plugins
    use({ 'nvim-treesitter/nvim-treesitter', run = function() vim.fn['TSUpdate']() end })
    use({ 'nvim-telescope/telescope.nvim', tag = '0.1.0' })
    use({ 'nvim-telescope/telescope-file-browser.nvim' })
    use({ 'nvim-telescope/telescope-ui-select.nvim' })
    use({ 'nvim-telescope/telescope-fzf-native.nvim',
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' })

    -- lsp/autocomplete
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
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
    }
    use({ 'simrat39/rust-tools.nvim' })

    -- debugging
    use({ 'mfussenegger/nvim-dap' })
    use({ 'rcarriga/nvim-dap-ui' })
    use({ 'theHamsta/nvim-dap-virtual-text' })
    use({ 'nvim-telescope/telescope-dap.nvim' })
    use({ 'leoluz/nvim-dap-go' })

    -- auto brackets and xml tags
    use({ 'windwp/nvim-autopairs' }) -- bracket pairs
    use({ 'tpope/vim-surround' }) -- xml/html tags TODO: learn the keybinds better
    -- decorative fluff
    use({ "catppuccin/nvim", as = "catppuccin" }) -- mocha (the darkest variant)
    use({ 'kyazdani42/nvim-web-devicons' }) --icons
    use({ 'lukas-reineke/indent-blankline.nvim' }) --display indents
    use({ 'lewis6991/gitsigns.nvim' })
    use({ 'nvim-lualine/lualine.nvim' })
    -- pseudo-productivity
    --
    use({ 'numToStr/Comment.nvim' }) --comment helper
    use({ 'kdheepak/lazygit.vim' }) --lazygit inside vim
    use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" }
    })
    -- do the packing
    if packer_bootstrap then
        require("packer").sync()
    end
end)
