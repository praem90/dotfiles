local Job = require'plenary.job'

local M = {}

M.title = "Git"

M.push = function (opts)
    opts.args = {"push"}
    opts.messages = vim.tbl_extend('keep', {
        processing = "Pushing...",
        success = "Pushed",
        error = "Unable to push",
    }, opts.messages or {})

    M.exec(opts)
end

M.pull = function (opts)
    opts.args = {"pull"}
    opts.messages = vim.tbl_extend('keep', {
        processing = "Pulling...",
        success = "Pulled",
        error = "Unable to pull",
    }, opts.messages or {})

    M.exec(opts)
end

M.fetch = function (opts)
    opts.args = {"fetch"}
    opts.messages = vim.tbl_extend('keep', {
        processing = "Fetching...",
        success = "Fetched",
        error = "Unable to fetch",
    }, opts.messages or {})

    M.exec(opts)
end

M.exec = function (opts)
    opts = opts or {}
    local notify_opts = vim.tbl_extend("keep", {title = M.title }, opts.notify_opts or {})
    notify_opts.replace = vim.notify(opts.messages.processing, vim.log.levels.INFO, notify_opts)
    Job:new({
        command = 'git',
        args = opts.args,
        cwd = vim.fn.getcwd(),
        on_exit = vim.schedule_wrap( function(_, return_val)
            if return_val == 0 then
                notify_opts.icon = ""
                vim.notify(opts.messages.success, vim.log.levels.INFO, notify_opts)
            else
                notify_opts.icon = ""
                vim.notify(opts.messages.error, vim.log.levels.ERROR, notify_opts)
            end
        end),
    }):start()
end

M.setup = function (opts)
    opts = opts or {}
    vim.keymap.set("n", "<leader>gp", function ()
        M.push(opts)
    end)
    vim.keymap.set("n", "<leader>gl", function ()
       M.pull(opts)
    end)
    vim.keymap.set("n", "<leader>gch", function ()
       M.fetch(opts)
    end)
end

return M
