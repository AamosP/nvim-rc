local dap = require('dap')

dap.adapters.codelldb = {
    type = 'server',
    port = "${port}",
    executable = {
        -- CHANGE THIS to your path!
        command = '/home/aamos/codelldb/extension/adapter/codelldb',
        args = { "--port", "${port}" },

        -- On windows you may have to uncomment this:
        -- detached = false,
    }
}

dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
    },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

vim.keymap.set("n", "<leader>p", function()
    dap.toggle_breakpoint()
end)
vim.keymap.set("n", "<F5>", function()
    dap.continue()
end)

-- nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
--    nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>
-- nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>
-- nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>
--    nnoremap <silent> <Leader>b <Cmd>lua require'dap'.toggle_breakpoint()<CR>
--    nnoremap <silent> <Leader>B <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
-- nnoremap <silent> <Leader>lp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
--    nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>
--    nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>
