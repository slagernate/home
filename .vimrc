

set tabstop=4       " The width of a TAB is set to 4. 
                    " Still it is a \t. It is just that 
                    " Vim will interpret it to be having 
                    " a width of 4. 
 
set shiftwidth=4    " Indents will have a width of 4 
 
set softtabstop=4   " Sets the number of columns for a TAB 
 
set expandtab       " Expand TABs to spaces 

let mapleader = ","

" Beginning and end of line
nnoremap H ^
nnoremap L $

" BEST MAP EVER: no longer need escape key
inoremap kk <esc> 

" General abbreviations
iabbrev adn and
iabbrev teh the
iabbrev ned end 
iabbrev waht what
iabbrev mihgt might
iabbrev hve have
iabbrev hvae have
iabbrev monht month
iabbrev mohtn month
iabbrev mothn month
iabbrev optelectrode optoelectrode
iabbrev optoelcerde optoelectroe
iabbrev optoeelctrode optoelectrode 
iabbrev opteolctrode optoelectrode 
iabbrev optoelectorde optoelectrode 
iabbrev optoelectroe optoelectrode 
iabbrev optoeelctode optoelectrode 
iabbrev opeoelectrode optoelectrode 
iabbrev ptoeltorde optoelectrode 
iabbrev optoeelctrode optoelectrode 
iabbrev optoeletrode optoelectrode 
iabbrev comand command

" Signature
:iabbrev ssig Thanks, <cr>Nate

" Verilog abbreviations
autocmd FileType verilog iabbrev rr register

" Add // comment
autocmd FileType verilog nnoremap <buffer> <leader>c myI//<esc>`yll
autocmd FileType c nnoremap <buffer> <leader>c myI//<esc>`yll
autocmd FileType python nnoremap <buffer> <leader>c myI#<esc>`yll
autocmd FileType vim nnoremap <buffer> <leader>c myI"<esc>`yll

" Clear current line
nnoremap <leader>d ddO<esc>

" Easy editing of vimrc
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <silent> <leader>sv :source $MYVIMRC<cr>

" Add quotes around current word
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel

" Add quotes around visual selection

nnoremap: <space> i<space><esc> 
nnoremap: : 

"nnoremap <expr> <silent> <c-a> expand('<cWord>') =~# '\d+\.\d+

syntax on 

set autoindent 
set smartindent 
set smarttab 
set nu

set clipboard=unnamed
