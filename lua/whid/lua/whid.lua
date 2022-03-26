local api = vim.api
local buf, win

local function open_window()
    buf = api.nvim_create_buf(false, true)
    api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

    win = api.nvim_open_win(buf, true, opts)
end

local function whid()

end

return {
}
