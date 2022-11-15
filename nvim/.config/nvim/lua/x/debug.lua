-- Debugger config
local dap = require('dap')
vim.keymap.set("n", "<F5>", dap.continue)
vim.keymap.set("n", "<F7>", dap.step_over)
vim.keymap.set("n", "<F8>", dap.step_into)
vim.keymap.set("n", "<F9>", dap.step_out)
vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint)
vim.keymap.set("n", "<Leader>dr", dap.repl.open)
vim.keymap.set("n", "<Leader>B", "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
vim.keymap.set("n", "<Leader>lp",
    "<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>")
require('nvim-dap-virtual-text').setup()
require("dapui").setup({
    layouts = {
        {
            elements = {
                "watches",
                "scopes",
                "breakpoints",
                "stacks",
            },
            size = 40, -- 40 columns
            position = "left",
        },
    },
})
-- open debugger UI when you start a session
local dapui = require('dapui')
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

-- go premade configs for dap/delve
require('dap-go').setup()
vim.keymap.set("n", "<Leader>dt", require('dap-go').debug_test) -- TODO: this shouldnt be a global keybind


