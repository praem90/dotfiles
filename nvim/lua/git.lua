local Job = require'plenary.job'

local M = {}

M.title = "Git"

M.push = function ()
    local notification_record = vim.notify("Pushing...", vim.log.levels.INFO, {title = M.title})
    Job:new({
        command = 'git',
        args = { 'push' },
        cwd = vim.fn.getcwd(),
        on_exit = vim.schedule_wrap( function(j, return_val)
            if return_val == 0 then
                vim.notify( "Pushed to remote", vim.log.levels.INFO, {title = M.title, replace = notification_record})
            else
                vim.notify( "Unable to push", vim.log.levels.ERROR, {title = M.title, replace = notification_record})
            end
        end),
    }):start()
end

M.pull = function ()
    local notification_record = vim.notify("Pulling...", vim.log.levels.INFO, {title = M.title})
    Job:new({
        command = 'git',
        args = { 'pull' },
        cwd = vim.fn.getcwd(),
        on_exit = vim.schedule_wrap( function(j, return_val)
            if return_val == 0 then
                vim.notify( "Pulled", vim.log.levels.INFO, {title=M.title, replace=notification_record})
            else
                vim.notify( "Unable to pull", vim.log.levels.ERROR, {title=M.title, replace=notification_record})
            end
        end),
    }):start()
end

M.fetch = function ()
    local notify_opts = {title = M.title}
    notify_opts.replace = vim.notify("Fetching...", vim.log.levels.INFO, notify_opts)
    Job:new({
        command = 'git',
        args = { 'fetch' },
        cwd = vim.fn.getcwd(),
        on_exit = vim.schedule_wrap( function(j, return_val)
            if return_val == 0 then
                vim.notify( "Fetched", vim.log.levels.INFO, notify_opts)
            else
                vim.notify( "Unable to fetch", vim.log.levels.ERROR, notify_opts)
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
