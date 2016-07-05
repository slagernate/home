
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.

set shiftwidth=4    " Indents will have a width of 4

set softtabstop=4   " Sets the number of columns for a TAB

set expandtab       " Expand TABs to spaces

nnoremap: <space> i<space><esc>
nnoremap: : 


syntax on

set autoindent
set smartindent
set smarttab

 " Remap 0 to first non-blank character in line
 map 0 ^
