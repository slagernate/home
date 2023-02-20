set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" shortcut for leaving terminal mode
:tnoremap kk <C-\><C-N>

" Window navigation in terminal mode
:tnoremap <A-h> <C-\><C-N><C-w>h
:tnoremap <A-j> <C-\><C-N><C-w>j
:tnoremap <A-k> <C-\><C-N><C-w>k
:tnoremap <A-l> <C-\><C-N><C-w>l

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
"nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Declare the list of plugins.
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'davidhalter/jedi-vim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'olimorris/onedarkpro.nvim'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
"Plug 'ludovicchabant/vim-gutentags'
Plug 'will133/vim-dirdiff'
Plug 'github/copilot.vim'

Plug 'nvim-telescope/telescope-file-browser.nvim'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

nnoremap <c-J> J
nnoremap <A-u> <c-u>
nnoremap <A-d> <c-d>
nnoremap K 7<c-y>
nnoremap J 7<c-e>

nnoremap zz ZZ
nnoremap ZZ zz

" Set working directory to current terminal directory
tnoremap <A-z> pwd\|xclip<CR><C-\><C-n>:cd <C-r>+<CR>i

" ESC key giving me arthritis
inoremap jf <Esc>
inoremap kk <Esc>

" Enable blinking together with different cursor shapes for insert/command mode, and cursor highlighting
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
\,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
\,sm:block-blinkwait175-blinkoff150-blinkon175


lua require('init')

"" Open file browser in the current directory
"nnoremap <leader>fb :Telescope file_browser<CR>
"
"" Open file browser in the directory of the current buffer and select the buffer
"nnoremap <leader>fb :Telescope file_browser cwd=%:p:h hidden=true search='**/*'<CR>
"

