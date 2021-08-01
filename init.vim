" ================ Sets and all that =========================================
syntax on
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

" ================ Plugins ====================================================
call plug#begin(stdpath('data') . '/plugged')
" Telescope requirements
Plug 'kristijanhusak/orgmode.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'gruvbox-community/gruvbox'
Plug 'neovim/nvim-lspconfig'				" Neovim Language Server
Plug 'Shougo/deoplete.nvim'
Plug 'deoplete-plugins/deoplete-lsp'		" Deoplete required for hover and complete?
Plug 'deoplete-plugins/deoplete-jedi'		" Python deoplete plugin
Plug 'ryanoasis/vim-devicons'
call plug#end()

" ================ Plugins Specific ==============================================
" NERDTree stuff
let NERDTreeQuitOnOpen = 1
let NERDTreeDirArrows = 0 
let NERDTreeChDirMode=3

" deoplete specific
let g:deoplete#enable_at_startup = 1

" ================ Themes ====================================================
colorscheme gruvbox
let g:airline_theme = 'wombat'
highlight Normal guibg=none

" ================ Mappings ==================================================
let mapleader="\<space>"
" Disable Arrow keys in Normal mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
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

map <S-F1> :Explore<CR> " can probable remove this as dont use Explore
nnoremap <Leader>f :NERDTreeToggle<Enter>
nnoremap <Leader>1 :NERDTreeToggle c:\users\Christophe\Documents\Coding\<Enter>

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
let g:python3_host_prog = 'C:\\Users\\christophe\\AppData\\Local\\Programs\\Python\\Python39\\python.exe'
