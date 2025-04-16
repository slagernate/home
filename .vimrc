set shell=bash\ -l

set tabstop=4       " The width of a TAB is set to 4.
                   " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.

set shiftwidth=4    " Indents will have a width of 4

set softtabstop=4   " Sets the number of columns for a TAB

set expandtab       " Expand TABs to spaces

" Window navigation
:inoremap <A-h> <C-\><C-N><C-w>h
:inoremap <A-j> <C-\><C-N><C-w>j
:inoremap <A-k> <C-\><C-N><C-w>k
:inoremap <A-l> <C-\><C-N><C-w>l
:nnoremap <A-h> <C-w>h
:nnoremap <A-j> <C-w>j
:nnoremap <A-k> <C-w>k
:nnoremap <A-l> <C-w>l

" Map <C-w><A-h> to move the current buffer to the left
:nnoremap <C-w><A-h> <C-w>H
:nnoremap <C-w><A-j> <C-w>J
:nnoremap <C-w><A-k> <C-w>K
:nnoremap <C-w><A-l> <C-w>L

" Beginning and end of line
nnoremap H ^
vnoremap H ^
nnoremap L $
vnoremap L $

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

inoremap <S-Space> _

" Signature
:iabbrev ssig Thanks, <cr>Nate

" auto change directories:
set autochdir

" Verilog abbreviations
autocmd FileType verilog iabbrev rr register

" set <leader> to , key
let mapleader = ","

"augroup create_new_entry_in_parameter_list
"    " Add comma and space (to keep appending to list)
"    autocmd FileType systemverilog,verilog <leader>a viW<esc>a,<space>.()<esc>
"    autocmd FileType cpp,c,java,scala,python,sh,ruby,tcl <leader>a viW<esc>a,<space><esc>
"augroup END

augroup default_tab_stop
    autocmd FileType systemverilog,verilog setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType cpp,c setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType java,scala,python,sh,ruby,tcl,proto setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType conf,fstab,txt,toml setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType tex setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType mail setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType vim setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType lua setlocal ts=4 sts=4 sw=4 expandtab
augroup END

augroup commenting_blocks_of_code
    autocmd FileType systemverilog,verilog,c,cpp,java,scala,rust,proto let b:comment_leader = '// '
    autocmd FileType sh,ruby,python,tcl,make,cmake let b:comment_leader = '# '
    autocmd FileType conf,fstab,txt,toml let b:comment_leader = '# '
    autocmd FileType tex let b:comment_leader = '% '
    autocmd FileType mail let b:comment_leader = '> '
    autocmd FileType vim let b:comment_leader = '" '
    autocmd FileType lua let b:comment_leader = '-- '
augroup END

noremap <silent> <leader>cc :<C-B>silent <C-E>s/^\([[:blank:]]*\)/\1<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> <leader>cu :<C-B>silent <C-E>s/^\([[:blank:]]*\)\V<C-R>=escape(b:comment_leader,'\/')<CR>/\1/e<CR>:nohlsearch<CR>


" Align next line to current cursor position
nnoremap <leader>a mqj0=80i <esc>`qjdt=
nnoremap <leader>:: mqj0f:80i <esc>`qjdt:
nnoremap <leader>)) mqj0f)80i <esc>`qjdt)
nnoremap <leader>(( mqj0f(80i <esc>`qjdt(
nnoremap <leader>== mqj0f=80i <esc>`qjdt=
"nnoremap <leader>PP mqj0fP80i <esc>`qjdt(

" Clear current line
nnoremap <leader>d ddO<esc>

" Easy editing of vimrc
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <silent> <leader>sv :source $MYVIMRC<cr>

" Add quotes around current word
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
nnoremap <leader>) viw<esc>a)<esc>bi(<esc>lel
nnoremap <leader>( viw<esc>a)<esc>bi(<esc>lel
nnoremap <leader>{ viw<esc>a}<esc>bi{<esc>lel
nnoremap <leader>} viw<esc>a}<esc>bi{<esc>lel

" Add quotes around visual selection

"nnoremap: <space> i<space><esc>
"nnoremap <space> <c-d>
"nnoremap: :

"nnoremap <expr> <silent> <c-a> expand('<cWord>') =~# '\d+\.\d+
"
" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P
syntax on

set autoindent
set smartindent
set smarttab
set rnu
set nu

set clipboard=unnamed

" no swap files plz
set noswapfile
set shortmess=A

"Rename tabs to show tab# and # of viewports
set tabpagemax=15
hi TabLineSel term=bold cterm=bold ctermfg=16 ctermbg=229
hi TabWinNumSel term=bold cterm=bold ctermfg=90 ctermbg=229
hi TabNumSel term=bold cterm=bold ctermfg=16 ctermbg=229

hi TabLine term=underline ctermfg=16 ctermbg=145
hi TabWinNum term=bold cterm=bold ctermfg=90 ctermbg=145
hi TabNum term=bold cterm=bold ctermfg=16 ctermbg=145
if exists("+showtabline")
    function! MyTabLine()
        let s = ''
        let wn = ''
        let t = tabpagenr()
        let i = 1
        while i <= tabpagenr('$')
            let buflist = tabpagebuflist(i)
            let winnr = tabpagewinnr(i)
            let s .= '%' . i . 'T'
            let s .= (i == t ? '%1*' : '%2*')
            let s .= ' '
            let wn = tabpagewinnr(i,'$')

            let s .= (i== t ? '%#TabNumSel#' : '%#TabNum#')
            let s .= i
            if tabpagewinnr(i,'$') > 1
                let s .= '.'
                let s .= (i== t ? '%#TabWinNumSel#' : '%#TabWinNum#')
                let s .= (tabpagewinnr(i,'$') > 1 ? wn : '')
            end

            let s .= ' %*'
            let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
            let bufnr = buflist[winnr - 1]
            let file = bufname(bufnr)
            let buftype = getbufvar(bufnr, 'buftype')
            if buftype == 'nofile'
                if file =~ '\/.'
                    let file = substitute(file, '.*\/\ze.', '', '')
                endif
            else
                let file = fnamemodify(file, ':p:t')
            endif
            if file == ''
                let file = '[No Name]'
            endif
            let s .= file
            let s .= (i == t ? '%m' : '')
            let i = i + 1
        endwhile
        let s .= '%T%#TabLineFill#%='
        return s
    endfunction
    set stal=2
    set tabline=%!MyTabLine()
endif
