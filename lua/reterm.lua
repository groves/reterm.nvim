local last_used_job_id = nil

local function get_terminal_job_ids()
    local job_ids = {}
    for _, buf in ipairs(vim.fn.getbufinfo()) do
        local job_id = buf.variables.terminal_job_id
        if job_id then
            job_ids[job_id] = true
        end
    end
    return job_ids
end

local function replace_termcodes(s)
    return vim.api.nvim_replace_termcodes(s, true, true, true)
end

return function (opts)
    local job_ids = get_terminal_job_ids()
    assert(next(job_ids), "Didn't find any terminal jobs to talk to")
    opts = opts == nil and {} or opts
    local job_id = opts.job_id
    if job_id ~= nil then
        assert(job_ids[opts.job_id], "Passed in job id " .. opts.job_id .. " not an active terminal job id")
    else
        job_id = job_ids[last_used_job_id] and last_used_job_id or next(job_ids)
    end

    if opts.now then
        vim.fn.chansend(job_id, replace_termcodes("<C-c>"))
    end
    vim.fn.chansend(job_id, replace_termcodes('<Esc>[A<CR>'))
    last_used_job_id = job_id
end
