local popup = require("plenary.popup")
local p_window = require("telescope.pickers.window")
local finders = require("telescope.finders")
local state = require("telescope.state")
local builtins = require("telescope.builtin")
local actions = require("telescope.actions")
local make_entry = require "telescope.make_entry"

local M = {}

M.searchAll = function ()
    local filetype_win_id = popup.create("", {
        border = true,
        padding = {0, 0, 0, 0},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        col = 27,
        enter = true,
        height = 1,
        line = 7,
        title = "Glob Pattern",
        width = 76,
        cursorline = false,
        hightlight = nil,
        borderhighlight = "TelescopePromptBorder",
        titlehighlight = "TelescopePromptTitle",
    });

    local filetype_bufnr = vim.api.nvim_win_get_buf(filetype_win_id)
    vim.api.nvim_buf_set_option(filetype_bufnr, "buftype", "prompt")
    vim.api.nvim_buf_set_option(filetype_bufnr, "filetype", "TelescopePromptNormal")
    vim.api.nvim_win_set_option(filetype_win_id, "cursorline", false)
    local filetype_prefix = "> "
    vim.fn.prompt_setprompt(filetype_bufnr, filetype_prefix)
    local file_type = ""
    vim.api.nvim_buf_set_lines(filetype_bufnr, 0, -1, false, {filetype_prefix})
    vim.api.nvim_win_set_cursor(filetype_win_id, {1, #filetype_prefix + 1})

    vim.api.nvim_buf_attach(filetype_bufnr, false, {
        on_lines = function()
            local lines = vim.api.nvim_buf_get_lines(filetype_bufnr, 0, 1, false)
            file_type = string.sub(lines[1], #filetype_prefix + 1)
        end
    })

    builtins.find_files({
        finder = finders.new_job(function(prompt)
            if not prompt or prompt == "" then
                return nil
            end
            local command = { "rg", "--color", "never", "--vimgrep"}
            if file_type ~= "" and file_type ~= nil then
                table.insert(command, "--glob")
                table.insert(command, file_type)
            end
            table.insert(command, prompt)
            return vim.tbl_flatten(command)
        end, make_entry.gen_from_vimgrep(), nil, vim.loop.cwd()),
        get_window_options = function(picker, max_columns, max_lines)
            local layout_opts = p_window.get_window_options(picker, max_columns, max_lines)
            layout_opts.results.height = layout_opts.results.height - 3
            layout_opts.results.line = 10
            layout_opts.prompt.line = 4
            print(vim.inspect(layout_opts.prompt))

            return layout_opts
        end,
        attach_mappings = function(_, map)
            local picker_close = function(p_bufnr)
                actions.close(p_bufnr)
                if vim.api.nvim_win_is_valid(filetype_win_id) then
                    vim.api.nvim_win_close(filetype_win_id, true)
                end
            end
            map("i", "<C-c>", picker_close)
            map("n", "<ESC>", picker_close)
            map("i", "<TAB>", function()
                vim.api.nvim_set_current_win(filetype_win_id)
                vim.api.nvim_set_current_buf(filetype_bufnr)
                local mode = vim.fn.mode()
                local keys = mode ~= "n" and "<ESC>A" or "A"
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "ni", true)
            end)

            return true
        end
    })

    local prompt_buffers = state.get_existing_prompt_bufnrs()
    local prompt_bufnr = prompt_buffers[#prompt_buffers]

    vim.api.nvim_clear_autocmds({
        group = "PickerInsert",
        event = "BufLeave",
        buffer = prompt_bufnr,
    })

    local prompt_status = state.get_status(prompt_bufnr)
    prompt_status["filetype_bufnr"] = filetype_bufnr;
    state.set_status(prompt_bufnr, prompt_status)

    vim.api.nvim_buf_set_keymap(filetype_bufnr, "i", "<TAB>", "<cmd>lua vim.api.nvim_set_current_win(".. prompt_status.prompt_win .. ")<CR>", {})
    vim.api.nvim_buf_set_keymap(filetype_bufnr, "n", "<TAB>", "<cmd>lua vim.api.nvim_set_current_win(".. prompt_status.prompt_win .. ")<CR>", {})

    -- vim.api.nvim_create_autocmd({"WinEnter"}, {
    --     buffer = filetype_bufnr,
    --     callback = function ()
    --         local mode = vim.fn.mode()
    --         local keys = mode ~= "n" and "<ESC>A" or "A"
    --         vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "ni", true)
    --     end
    -- });
end

return M
