" ================ Sets and all that =========================================
syntax on
set path+=**
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set autoindent
set copyindent
set relativenumber
set hidden
set nohlsearch
set noerrorbells
set nowrap
set smartcase
set noswapfile
set nobackup
set termguicolors
set scrolloff=8
set incsearch
set undofile
set signcolumn=yes
"set colorcolumn=80
set encoding=UTF-8
set showtabline=2  " Only want tab if 2 tabs are open
set splitbelow
set splitright
set laststatus=2
set autochdir
set list
"set listchars=tab:\¦\, eol:\↵\
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
set nofoldenable    " disable folding because why?...
set noshowmode
set linespace=0
set linebreak
set clipboard=unnamedplus
set cursorline
set mouse=a
" Vive la France:
set nospell
set spelllang+=fr
" ================ Plugins ====================================================
call plug#begin(stdpath('data') . '/plugged')
" Telescope requirements
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'gruvbox-community/gruvbox'
Plug 'neovim/nvim-lspconfig'			" Neovim Language Server

Plug 'L3MON4D3/luasnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-nvim-lsp'

Plug 'kristijanhusak/orgmode.nvim'
Plug 'rmehri01/onenord.nvim', { 'branch': 'main' }
Plug 'projekt0n/github-nvim-theme'
Plug 'habamax/vim-godot'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
" Plug 'vim-scripts/brainbrain.nvim'       " My own plugin!
call plug#end()

" ================ Plugins Specific ===========================================
" NERDTree stuff
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeDirArrows = 0 
let g:NERDTreeChDirMode=3

lua << EOF
-- Load custom tree-sitter grammar for org filetype
require('orgmode').setup_ts_grammar()

require'nvim-treesitter.configs'.setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    disable = {'org'}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
    additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
  },
  ensure_installed = {'org'}, -- Or run :TSUpdate org
}
require('orgmode').setup({
  org_agenda_files = {'~\\OneDrive\\orgmode\\**'},
  org_default_notes_file = '~\\OneDrive\\orgmode\\refile.org',
  org_todo_keywords = {'TODO', 'INPROGRESS','WAITING','|','DONE','CANCELLED'
  },
  org_todo_keyword_faces = {
      TODO = ':foreground red : weight bold',
      DONE = ':foreground green : slant italic'},
  org_hide_leading_stars = true,
  org_archive_location = 'archive.org'})
EOF

" Nvim-Cmp
set completeopt=menu,menuone,noselect
lua <<EOF
  -- Setup my luasnip stuff
  require('snippets')
  ls = require('luasnip')
  -- Setup nvim-cmp.
  local cmp = require'cmp'
  cmp.setup({
    snippet = {
      expand = function(args)
        -- For `luasnip` user.
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = {
      ['<C-d>']     = cmp.mapping.scroll_docs(-4),
      ['<C-f>']     = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>']     = cmp.mapping.close(),
      ['<CR>']      = cmp.mapping.confirm({ select = true }),
      ['<C-k>']     = cmp.mapping(function(fallback)
                    if ls.expand_or_jumpable() then
                        ls.expand_or_jump()
                    end
                    end, {"i", "s"}),
      ['<C-j>']     = cmp.mapping(function(fallback)
                    if ls.jumpable(-1) then
                        ls.jump(-1)
                    end
                    end, {"i", "s"}),
      ['<C-l>']     = cmp.mapping(function(fallback)
                    if ls.choice_active() then
                        ls.change_choice(1)
                    end
                    end, {"i", "s"}),
    },
    sources = {
      { name = 'orgmode' },
      { name = 'nvim_lua' },
      { name = 'nvim_lsp' },
      { name = 'path' },
      -- For luasnip user.
      { name = 'luasnip' },
      { name = 'buffer' },
      },
    experimental = {
        native_menu = false,
        ghost_text = true
        }
  })
EOF

lua << EOF
require'lspconfig'.gdscript.setup({
  on_attach = function (client) --On Attach run the function client
    local _notify = client.notify
    client.notify = function (method, params)
      if method == 'textDocument/didClose' then
          -- Godot doesn't implement didClose yet
          return
      end
      _notify(method, params)
    end
  end,
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
})
require'lspconfig'.clangd.setup({
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
})
require'lspconfig'.jedi_language_server.setup({
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
})

require'nvim-web-devicons'.setup({
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
})
require('telescope').setup({
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
})
EOF
" ================ Themes ====================================================
colorscheme gruvbox
let g:airline_theme = 'molokai'
highlight Normal guibg=none

command! GruvboxTheme lua require('changetheme').gruvbox_theme()
command! GithubTheme lua require('changetheme').github_theme()
command! Atari lua require('changetheme').atari()
command! Tiny lua require('changetheme').tiny()
command! FiraMono lua require('changetheme').firamono()
command! FiraCodeNF lua require('changetheme').firacodenf()
command! Terminus lua require('changetheme').terminus()
command! OneNordLight lua require('changetheme').onenordlight()
command! OneNordDark lua require('changetheme').onenorddark()
" ================ Mappings ==================================================
let mapleader="\<space>"
" Start a powershell in a split window
nmap <leader>$ :split term://powershell<CR>
" Disable Arrow keys in Normal mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
"To map <Esc> to exit terminal-mode: >
tnoremap <Esc> <C-\><C-n>
" Disable Arrow keys in Insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
" move normally between wrapped lines
nmap j gj
nmap k gk
vmap j gj
vmap k gk
" Quick jumping between windows splits
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l
" And this as well
nmap <silent> <A-Up>   :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right>:wincmd l<CR>
" Open new splits easily
map vv <C-W>v
map ss <C-W>s
map Q  <C-W>q
nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>i
nnoremap <Leader>f :NERDTree<CR>
nnoremap <Leader>1 :NERDTree C:$HOMEPATH/Documents/Coding<CR>
nnoremap <Leader>2 :NERDTree C:$HOMEPATH/AppData/Local/nvim<CR>
nnoremap <Leader>3 :NERDTree C:$HOMEPATH/OneDrive/OrgMode<CR>
nnoremap <Leader>4 :NERDTree C:$HOMEPATH/AppData/Local/nvim-data<CR>
" buffers
nnoremap <C-tab>   :bn<CR>
nnoremap <C-S-tab> :bp<CR>
" Telescope Mappings
nnoremap <leader>5 <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>gs <cmd>lua require('telescope.builtin').grep_string()<cr>
nnoremap <leader>cs <cmd>lua require('telescope.builtin').colorscheme()<cr>
nnoremap <leader>co <cmd>lua require('telescope.builtin').commands()<cr>
nnoremap <leader>qf <cmd>lua require('telescope.builtin').quickfix()<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>ii :e $MYVIMRC<cr>
nnoremap <leader>en <cmd>lua require('my_telescope').edit_neovim()<cr>
nnoremap <leader>eo <cmd>lua require('my_telescope').edit_orgmode()<cr>
nnoremap <leader>ec <cmd>lua require('my_telescope').edit_coding()<cr>
nnoremap <leader>ee <cmd>lua vim.diagnostic.open_float()<cr>
nnoremap <leader>yy <cmd>lua require('plugin_x1').createFloatingWindow()<cr>
" deoplete / using tab for auto complete
" use tab to forward cycle
" inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
" lsp mapping
nnoremap <leader>vd  :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>vi  :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>vsh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>vrr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>vrn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>vh  :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>vca :lua vim.lsp.buf.code_action()<CR>
" ================ Local Setup ===============================================
let g:godot_executable = 'D:/godot/godot.exe'
let g:python3_host_prog = '~/AppData/Local/Programs/Python/Python39/python.exe'
