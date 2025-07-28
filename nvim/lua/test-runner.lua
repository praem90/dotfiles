require('neotest').setup({
    adapters = {
        require('neotest-pest'),
        require('neotest-golang')({
            runner = "gotestsum"
        }),
    }
})

vim.keymap.set('n', '<leader>nt', '<Cmd>lua require("neotest").run.run()<CR>', {silent = true})
vim.keymap.set('n', '<leader>nw', '<Cmd>lua require("neotest").watch.toggle()<CR>', {silent = true})
vim.keymap.set('n', '<leader>no', '<Cmd>lua require("neotest").output.open()<CR>', {silent = true})
vim.keymap.set('n', '<leader>ns', '<Cmd>lua require("neotest").summary.toggle()<CR>', {silent = true})

