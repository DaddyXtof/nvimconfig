local M = {}
function M.github_theme()
    require("github-theme").setup({
        themeStyle = "light"
    })
end
function M.gruvbox_theme()
    vim.cmd([[
    set background=dark
    colorscheme gruvbox
    let g:airline_theme = 'wombat'
    ]])
end
return M
