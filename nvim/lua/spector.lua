-- vimspector keybindings
function map_helper(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


map_helper("n", "<leader>dd", ":call vimspector#Launch()<CR>");
map_helper("n", "<leader>dx", ":call vimspector#Reset()<CR>");
map_helper("n", "<leader>dc", ":call vimspector#Continue()<CR>");

map_helper("n", "<leader>dt", ":call vimspector#ToggleBreakpoint()<CR>");
map_helper("n", "<leader>db", ":call vimspector#ListBreakpoints()<CR>");
map_helper("n", "<leader>dT", ":call vimspector#ClearBreakpoints()<CR>");

map_helper("n", "<leader>dh", ":call vimspector#StepOut()<CR>");
map_helper("n", "<leader>dl", ":call vimspector#StepInto()<CR>");
map_helper("n", "<leader>dj", ":call vimspector#StepOver()<CR>");

