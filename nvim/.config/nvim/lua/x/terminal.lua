local group = vim.api.nvim_create_augroup("neovim_terminal", { clear = false })

vim.api.nvim_create_autocmd({ "TermOpen" }, {
    callback = function()
        vim.cmd([[
            tnoremap <buffer> <Esc> <c-\><c-n>
            setlocal listchars= nonumber norelativenumber
            startinsert
       ]]);
    end
})
