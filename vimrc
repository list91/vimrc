" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim
set expandtab
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4


set number

colorscheme desert
syntax on

set noerrorbells
set novisualbell

map <C-space> ?

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"command! -nargs=* javaStart call CreateProject(<d-args>)
"function CreateProject(...)


" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction
" Активация плагина NERDTree
call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
call plug#end()

" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p

"свитчи в норм режиме
"открыть закрыть бар
nnoremap <C-b> :NERDTreeToggle<CR>

"nnoremap <C-x> :NERDTree t
nnoremap <C-x> :tabe getline(".")<CR>
"nnoremap <C-Right> :tabnext
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-Left> :tabprevious<CR>

"nnoremap <leader>n :NERDTreeFocus<CR>
"nnoremap <C-n> :NERDTree<CR>
"nnoremap <C-f> :NERDTreeFind<CR>
