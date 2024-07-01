local dap, dapui = require("dap"), require("dapui")

dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { os.getenv("HOME") .. "/.vim/vscode-php-debug/out/phpDebug.js" }
}

dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Listen for Xdebug',
    hostname = '127.0.0.1',
    port = 9003,
    pathMappings = {
        ['/app/'] = "${workspaceFolder}",
    },
  }
}

dapui.setup()

function map_helper(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


map_helper("n", "<leader>dd", ":lua require'dap'.continue()<CR>");
map_helper("n", "<leader>dx", ":lua require'dap'.terminate()<CR>");
map_helper("n", "<leader>dr", ":lua require'dap'.restart()<CR>");
-- map_helper("n", "<leader>dc", ":call vimspector#Continue()<CR>");

map_helper("n", "<leader>dt", ":lua require'dap'.toggle_breakpoint()<CR>");
map_helper("n", "<leader>db", ":lua require'dap'.list_breakpoints()<CR>");
map_helper("n", "<leader>dT", ":lua require'dap'.clear_breakpoints()<CR>");

map_helper("n", "<leader>dv", ":lua require'dap'.step_over()<CR>");
map_helper("n", "<leader>di", ":lua require'dap'.step_into()<CR>");
map_helper("n", "<leader>do", ":lua require'dap'.step_out()<CR>");
map_helper("n", "<leader>dau", ":lua require'dapui'.toggle()<CR>");


dap.listeners.after.event_initialized["dapui_config"] = function()
    print("event_initialized");
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    print("event_terminated");
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
