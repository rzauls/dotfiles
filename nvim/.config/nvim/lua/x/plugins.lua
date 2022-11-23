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
    use({ "nvim-lua/plenary.nvim" }) -- Useful lua functions used by lots of plugins
    -- telescope/system plugins
    use({ 'nvim-lua/plenary.nvim' })
    use({ 'nvim-treesitter/nvim-treesitter', run = function() vim.fn['TSUpdate']() end })
    use({ 'nvim-telescope/telescope.nvim', tag = '0.1.0' })
    use({ 'nvim-telescope/telescope-file-browser.nvim' })
    use({ 'nvim-telescope/telescope-fzf-native.nvim',
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' })
    -- lsp/autocomplete
    use({ 'neovim/nvim-lspconfig' }) -- premade lsp configurations with sane defaults
    use({ 'simrat39/rust-tools.nvim' })
    -- autocomplete
    use({ 'hrsh7th/nvim-cmp' }) --autocomplete base layer
    use({ 'hrsh7th/cmp-nvim-lsp' })
    use({ 'hrsh7th/cmp-buffer' })
    use({ 'hrsh7th/cmp-path' })
    use({ 'f3fora/cmp-spell' }) -- spelling
    use({ 'hrsh7th/cmp-nvim-lua' })
    use({ 'L3MON4D3/LuaSnip', tag = 'v1.*' }) -- snippet engine (supports vs code snippet format)
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
    use({ 'ruifm/gitlinker.nvim' }) --git permalinks
    use({ 'numToStr/Comment.nvim' }) --comment helper
    use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end, ft = { "markdown" }
    })

    -- possible additions at some point:
    --  * schemaStore for json autocomplete? (needs json lsp setup then aswell)
    --    - can just initialize the schema store only when working with a
    --    json-buffer to avoid startup slowdown
    --  * ggandor/lightspeed.nvim for better motions

    -- do the packing
    if packer_bootstrap then
        require("packer").sync()
    end
end)
