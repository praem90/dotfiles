local Job = require'plenary.job'

local M = {}


M.push = function ()
    Job:new({
        command = 'git',
        args = { 'push' },
        cwd = vim.fn.getcwd(),
        on_exit = vim.schedule_wrap( function(j, return_val)
            if return_val == 0 then
                vim.notify( "Pushed to remote", vim.log.levels.INFO)
            else
                vim.notify( "Unable to push", vim.log.levels.ERROR)
            end
        end),
    }):start()
end

M.pull = function ()
    Job:new({
        command = 'git',
        args = { 'pull' },
        cwd = vim.fn.getcwd(),
        on_exit = vim.schedule_wrap( function(j, return_val)
            if return_val == 0 then
                vim.notify( "Pulled", vim.log.levels.INFO)
            else
                vim.notify( "Unable to pull", vim.log.levels.ERROR)
            end
        end),
    }):start()
end

M.fetch = function ()
    Job:new({
        command = 'git',
        args = { 'fetch' },
        cwd = vim.fn.getcwd(),
        on_exit = vim.schedule_wrap( function(j, return_val)
            if return_val == 0 then
                vim.notify( "Pulled", vim.log.levels.INFO)
            else
                vim.notify( "Git Fetched", vim.log.levels.ERROR)
            end
        end),
    }):start()
end

M.setup = function ()
    vim.keymap.set("n", "<leader>gp", M.push)
    vim.keymap.set("n", "<leader>gl", M.pull)
    vim.keymap.set("n", "<leader>gch", M.fetch)
end

return M
