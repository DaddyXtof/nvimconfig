local M = {}
function M.edit_neovim()
    require('telescope.builtin').live_grep {
    cwd= "~/AppData/Local/nvim",
    prompt="~ My Vim Config ~"
    }
end
return M
