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
set colorcolumn=80
set encoding=UTF-8
set showtabline=2  " Only want tab if 2 tabs are open
set splitbelow
set splitright
set laststatus=2
set autochdir
set list
set listchars=tab:\¦\ 
set nofoldenable    " disable folding because why?...
set noshowmode
set linespace=0
set clipboard=unnamedplus
set cursorline

" ================ Plugins ====================================================
call plug#begin(stdpath('data') . '/plugged')
" Telescope requirements
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'gruvbox-community/gruvbox'
Plug 'neovim/nvim-lspconfig'			" Neovim Language Server
Plug 'Shougo/deoplete.nvim'
Plug 'deoplete-plugins/deoplete-lsp'	" Deoplete required for hover & complete?
Plug 'deoplete-plugins/deoplete-jedi'	" Python deoplete plugin
Plug 'hrsh7th/nvim-compe'
Plug 'kristijanhusak/orgmode.nvim'
Plug 'projekt0n/github-nvim-theme'
Plug 'ryanoasis/vim-devicons'
call plug#end()

" ================ Plugins Specific ==============================================
" NERDTree stuff
let NERDTreeQuitOnOpen = 1
let NERDTreeDirArrows = 0 
let NERDTreeChDirMode=3

" deoplete specific
let g:deoplete#enable_at_startup = 1

" OrgMode
lua << EOF
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

" Nvim-Compe
set completeopt=menuone,noselect

let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true
let g:compe.source.luasnip = v:true
let g:compe.source.emoji = v:true

lua << EOF
require'compe'.setup({
  source = {
    orgmode = true
  }
})
EOF

" ================ Themes ====================================================
colorscheme gruvbox
let g:airline_theme = 'wombat'
highlight Normal guibg=none

command! GruvboxTheme lua require('changetheme').gruvbox_theme()
command! GithubTheme lua require('changetheme').github_theme()

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
" Quick jumping between splits
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l
" And this as well
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
" Open new splits easily
map vv <C-W>v
map ss <C-W>s
map Q  <C-W>q

map <S-F1> :Explore<CR> "can probable remove this as dont use Explore
nnoremap <Leader>f :NERDTreeToggle<Enter>
nnoremap <Leader>1 :NERDTreeToggle ~/Documents/Coding<Enter>

" buffers
nnoremap <tab> :bn<CR>
nnoremap <s-tab> :bp<CR>
nnoremap <leader>bd :bd<CR>

" Telescope Mappings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>i :e $MYVIMRC<CR>

" deoplete / using tab for auto complete
" use tab to forward cycle
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" use tab to backward cycle
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" ================ Local Setup ===============================================
let g:python3_host_prog = '~\\AppData\\Local\\Programs\\Python\\Python39\\python.exe'
