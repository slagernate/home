set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" shortcut for leaving terminal mode
:tnoremap kk <C-\><C-N>
:tnoremap jf <C-\><C-N>
:tnoremap fj <C-\><C-N>

" Window navigation in terminal mode
:tnoremap <A-h> <C-\><C-N><C-w>h
:tnoremap <A-j> <C-\><C-N><C-w>j
:tnoremap <A-k> <C-\><C-N><C-w>k
:tnoremap <A-l> <C-\><C-N><C-w>l

nnoremap <leader>fb <cmd>Telescope buffers<cr>
" nnoremap <leader>fh <cmd>Telescope help_tags<cr>

set scrollback=100000

" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Declare the list of plugins.
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-telescope/telescope.nvim',
" Plug 'davidhalter/jedi-vim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'olimorris/onedarkpro.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'rebelot/kanagawa.nvim'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'ludovicchabant/vim-gutentags'
Plug 'will133/vim-dirdiff'
Plug 'github/copilot.vim'
Plug 'junegunn/vim-easy-align'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'kassio/neoterm'
Plug 'psf/black'
Plug 'ntpeters/vim-better-whitespace'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'sindrets/diffview.nvim'

" nvim-dap
Plug 'mfussenegger/nvim-dap'

Plug 'nvim-neotest/nvim-nio'

" UI for nvim-dap
Plug 'rcarriga/nvim-dap-ui'

" Virtual text for debugging
Plug 'theHamsta/nvim-dap-virtual-text'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Copilot
" alternate accept key:
imap <silent><script><expr> <leader><Tab> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true


nnoremap <c-J> J
nnoremap <A-u> <c-u>
nnoremap <A-d> <c-d>
nnoremap K 7<c-y>
nnoremap J 7<c-e>

command! Noh noh
command! NOh noh

nnoremap <leader>w :w<CR>

" ESC key giving me arthritis
inoremap jk <Esc>:w<CR>
inoremap jf <Esc>:w<CR>
inoremap fj <Esc>:w<CR>
inoremap kk <Esc>:w<CR>

" Enable blinking together with different cursor shapes for insert/command mode, and cursor highlighting
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
\,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
\,sm:block-blinkwait175-blinkoff150-blinkon175

highlight FunctionName guifg=#FF0000 gui=bold
highlight link FunctionName Function

nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Open terminal in vertical split and go into insert mode
nnoremap <leader>vt :vsplit \| :term<CR>:startinsert<CR>

" Open terminal in current window and go into insert mode
nnoremap <leader>t :term<CR>:startinsert<CR>

" Tab key options:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

" Buffer shortcuts
" go to previous buffer
nnoremap <leader>bp :bp<CR>
" list buffers
nnoremap <leader>ls :ls<CR>

" Do not list full file path when listing buffers
set shortmess+=F

"" get cwd from terminal output
function! GetTerminalCWD()
    let l:line_num = line("$")
    while l:line_num >= 1
        let l:line = getline(l:line_num)
        " Adjusted regular expression to be more general
        let l:match = matchlist(l:line, '@.*:\zs.*\ze\$')
        if len(l:match) > 0
            " Remove leading and trailing spaces before returning
            return substitute(l:match[0], '^\s*\|\s*$', '', 'g')
        endif
        let l:line_num -= 1
    endwhile
    return ''
endfunction

nnoremap <leader>sd :execute "cd" GetTerminalCWD()<CR>

"" Black formatting
setlocal formatprg=black\ -q\ -
nnoremap <leader>b ggVGgq<C-o><C-o>

" don't auto comment next line
set formatoptions-=cro

" don't copy overwritten text to unnamed register when pasting
xnoremap p P

" shortcut for swapping current Word and the next word occuring after the next
" comma
nnoremap <leader>sw ma:s/\v(\w+),\s*(\w+)/\2, \1/<CR>:nohlsearch<Bar>:echo<CR>`a

" Map a in visual mode to a in normal mode
xnoremap a <esc>a


" Telescope

" replace above for with cwd=GitRoot()
function! GitRoot()
    let l:path = &buftype == 'terminal' ? getcwd() : expand('%:p:h')
    let l:git_root = system('git -C ' . shellescape(l:path, 1) . ' rev-parse --show-toplevel')
    return v:shell_error == 0 ? substitute(l:git_root, '\n$', '', '') : l:path
endfunction

" trying to also find amranth source file:
" nnoremap <leader>fg :lua require('telescope.builtin').live_grep({cwd = vim.fn.eval('GitRoot()'), find_command = {'rg', '--hidden', '--files', '--no-ignore'}})<CR>
" nnoremap <leader>fg :execute 'Telescope live_grep cwd=' . GitRoot() . ' find_command=rg,--hidden,--files,--no-ignore'<CR>

" Search in current git repo:
nnoremap <leader>ff :execute  'Telescope find_files cwd=' . GitRoot()<CR>
nnoremap <leader>fg :execute  'Telescope live_grep cwd=' . GitRoot()<CR>
nnoremap <leader>fiw :execute 'Telescope grep_string cwd=' . GitRoot()<CR>
nnoremap <leader>fu :execute  'Telescope lsp_document_symbols symbols=function'<CR>

" map('n', '<leader>ff', "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>", default_opts)

" start file browser in cwd always
nnoremap <leader>fd :Telescope file_browser<CR>

"" Open file browser in the current directory
"nnoremap <leader>fb :Telescope file_browser<CR>
"
"" Open file browser in the directory of the current buffer and select the buffer
"nnoremap <leader>fb :Telescope file_browser cwd=%:p:h hidden=true search='**/*'<CR>
"

" search and replace hotkey:
nnoremap <leader>sr :%s/\<<C-r><C-w>\>//g<Left><Left>

" Quick compile and come back
" navigate to terminal buffer to the right of current buffer,
" go into insert mode, hit up arrow key to get the last command,
" hit enter to execute the command, and then go back to the previous buffer
nnoremap <leader>co :w<CR><C-w>l<C-\><C-n>:startinsert<CR><Up><CR><C-\><C-n><C-w>h

" by default, use unamed register as clipboard
set clipboard=unnamedplus

lua << EOF
require("ibl").setup {}
EOF


lua << EOF
local dap = require('dap')

-- GDB Adapter for Remote Debugging
dap.adapters.gdb = {
    type = 'server',
    host = '10.40.62.166', -- Path to GDB
    port = '1234',
}

-- Remote Debugging Configuration
dap.configurations.cpp = {
    {
        name = "Attach to Remote GDB",
        type = "gdb",
        request = "launch",
        program = "/home/scifi/build-aarch64/bin/nixelfin4k/scifi-server_test", -- Remote binary
        cwd = "/home/scifi/build-aarch64/bin/nixelfin4k/", -- Remote working directory
        stopAtEntry = false,
        runInTerminal = true, -- Ensures the program runs in a terminal and forwards output
        args = {}, -- Command-line arguments
        setupCommands = {
            {
                description = "Enable pretty-printing",
                text = "-enable-pretty-printing",
                ignoreFailures = true,
            },
        },
        pipeTransport = {
            pipeCwd = "",
            pipeProgram = "ssh", -- Use SSH for remote debugging
            pipeArgs = { "nates@scifi" }, -- SSH user and host
            debuggerPath = "/usr/bin/gdb", -- Path to GDB on the remote machine
        },
        sourceFileMap = {
            ["/home/scifi/src"] = "/home/nates/github/headstage/src", -- Map remote source to local source
        },
    },
}

require('dap').set_log_level('TRACE')

require('dapui').setup({
    icons = { expanded = "▾", collapsed = "▸" },
    mappings = {
        -- Use default mappings or customize as needed
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
    },
    layouts = {
        {
            elements = {
                { id = "scopes", size = 0.25 },
                { id = "breakpoints", size = 0.25 },
                { id = "stacks", size = 0.25 },
                { id = "watches", size = 0.25 },
            },
            size = 40, -- Width of the window
            position = "left", -- Can be "left" or "right"
        },
        {
            elements = {
                { id = "repl", size = 0.5 },
                { id = "console", size = 0.5 },
            },
            size = 10, -- Height of the window
            position = "bottom", -- Can be "top" or "bottom"
        },
    },
    floating = {
        max_height = 0.9,
        max_width = 0.5,
        border = "single",
    },
    windows = { indent = 1 },
})

require('nvim-dap-virtual-text').setup()

local dap, dapui = require('dap'), require('dapui')

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
EOF

" lua << EOF
" require('lspconfig').clangd.setup{
  " cmd = {"clangd", "--log=verbose"},
  " filetypes = {"c", "cpp", "objc", "objcpp"},
" }
" EOF

" day
" colorscheme catppuccin-latte
" " :highlight Normal guibg=white
" colorscheme catppuccin-frappe
" colorscheme catppuccin-macchiato
" colorscheme catppuccin-mocha

" colorscheme tokyonight-day
" colorscheme tokyonight-storm
" colorscheme tokyonight-moon
colorscheme tokyonight-night
" night


