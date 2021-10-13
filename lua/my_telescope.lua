local M = {}
function M.edit_neovim()
    require('telescope.builtin').live_grep {
    cwd= "~/AppData/Local/nvim"
    }
end
function M.edit_orgmode()
    require('telescope.builtin').live_grep {
    cwd= "~/OneDrive/OrgMode"
    }
end
return M
