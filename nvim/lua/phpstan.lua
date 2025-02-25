local Job = require'plenary.job'

local M = {}

local namespace = vim.api.nvim_create_namespace('pream90.phpstan')
vim.diagnostic.config({
    virtual_text = true,
    underline = false,
}, namespace)

M.analyse =function ()
Job:new({
  command = './vendor/bin/phpstan',
  args = {
      'analyse',
      '--error-format=json',
      vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()),
  },
  cwd = vim.fn.getcwd(),
  on_exit = vim.schedule_wrap(function(j, return_val)
    if return_val == 0 then
      return
    end
    local result = j:result()
    local response = vim.json.decode(result[1])
    for file_path in pairs(response.files) do
        local bufnr = vim.fn.bufnr(file_path);
        local diagnostics = {}

        for i in pairs(response.files[file_path].messages) do
            local message = response.files[file_path].messages[i]
            local diagnostic = {
                bufnr = bufnr,
                lnum = message.line - 1,
                col = 0,
                message = message.message,
                source = message.tip,
                code = message.identifier,
                namespace = namespace
            }

            if message.ignorable then
                diagnostic.severity = vim.diagnostic.severity.WARN
            else
                diagnostic.severity = vim.diagnostic.severity.ERROR
            end

            table.insert(diagnostics, diagnostic)
        end

        vim.diagnostic.set(namespace, bufnr, diagnostics)
    end
  end),
}):start()

end

M.setup = function ()
    vim.api.nvim_create_autocmd({"BufReadPre", "BufWritePost"}, {
        pattern = {"*.php"},
        callback = M.analyse
    })
end

return M
