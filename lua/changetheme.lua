local M = {}
function M.github_theme()
    require("github-theme").setup({
        theme_style = "light",
        sidebars = {"terminal"},
        dark_float = true
    })
end
function M.gruvbox_theme()
    vim.cmd([[
    set background=dark
    colorscheme gruvbox
    let g:airline_theme = 'wombat'
    ]])
end
function M.atari()
    vim.cmd([[
    GuiFont Atari ST 8x16 System Font:h15
    ]])
end
function M.tiny()
    vim.cmd([[
    GuiFont Dina:h10
    ]])
end
function M.firamono()
    vim.cmd([[
    GuiFont Fira Mono:h12
    ]])
end
function M.firacodenf()
    vim.cmd([[
    GuiFont! FiraCode NF:h12
    ]])
end

function M.terminus()
    vim.cmd([[
    GuiFont! Terminus:h14
    ]])
end
return M
