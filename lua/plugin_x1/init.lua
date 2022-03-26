-- Check this article https://www.2n.pl/blog/how-to-write-neovim-plugins-in-lua
local function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end
local function lines_from(file)
  if not file_exists(file) then return {} end
  local lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end
local function createFloatingWindow()
    local stats  = vim.api.nvim_list_uis()[1]
    local width  = stats.width 
    local height = stats.height
    local bufh = vim.api.nvim_create_buf(false, true) --not listed and scratch buffer
    local cheat_file = "C:\\Users\\Christophe\\OneDrive\\OrgMode\\cheatsheet.org"
    local mytext = lines_from(cheat_file)
    local winId = vim.api.nvim_open_win(bufh, true,
        {relative='editor',
        style='minimal',
        width=width-10,
        height=height-10,
        col=5,
        row=5})
        vim.api.nvim_buf_set_lines(bufh,0,0,false,mytext)
end
return {
    createFloatingWindow = createFloatingWindow
}
