require('neotest').setup({
    adapters = {
        require('neotest-pest'),
        require('neotest-go'),
    }
})

vim.keymap.set('n', '<leader>tu', '<Cmd>lua require("neotest").run.run()<CR>', {silent = true})
vim.keymap.set('n', '<leader>to', '<Cmd>lua require("neotest").output.open()<CR>', {silent = true})
vim.keymap.set('n', '<leader>ts', '<Cmd>lua require("neotest").summary.toggle()<CR>', {silent = true})
