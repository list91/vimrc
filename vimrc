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
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-scripts/vim-gitgutter'
Plug 'morhetz/gruvbox'

Plug 'scrooloose/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dense-analysis/ale'

call plug#end()

let g:airline_theme='wombat'


" Установка цветовой схемы Gruvbox со стилем dark hard
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'

set shell=sh
let g:NERDTreeGitStatusShowIgnored = 1 " a heavy feature may cost much more time. default: 0

"""
" Initial NERDTree width
"let NERDTreeWinSize=50

" Close NERDtree when files was opened
"let NERDTreeQuitOnOpen=1

" Show NERDTree bookmarks
"let NERDTreeShowBookmarks=1

" Display arrows instead of ascii art in NERDTree
"let NERDTreeDirArrows=1

" Change current working directory based on root directory in NERDTree
"let NERDTreeChDirMode=2

" Start NERDTree in minimal UI mode (No help lines)
"let NERDTreeMinimalUI=1
"""


" Start NERDTree and put the cursor back in the other window.
"autocmd VimEnter * NERDTree
let NERDTreeMinimalUI=1

" Автоматически открывать NERDTree при старте Vim
"autocmd VimEnter * NERDTree
" Открывать NERDTree при запуске Vim без аргументов в текущей директории
autocmd VimEnter * if argc() == 0 | NERDTree | endif

" Отобразить пустое окно при запуске Vim
"autocmd VimEnter * execute 'silent! belowright 10new' | execute 'resize 5'


map <c-Up> :call cursor(line('.') - 2, col('.'))<CR>
map <c-Down> :call cursor(line('.') + 2, col('.'))<CR>

nnoremap <C-z> :call feedkeys("t")<CR>
"imap <C-CR> I just pressed Control+Enter<CR>


let NERDTreeShowBookmarks=1


"autocmd BufEnter * lcd %:p:h

"autocmd BufEnter * if &filetype == 'nerdtree' | echo expand('%:p:h') | endif


"свитчи в норм режиме
"открыть закрыть бар
nnoremap <C-b> :tabdo NERDTreeClose<CR>
nnoremap <C-g> :tabdo NERDTree<CR>

nnoremap <C-x> :q<CR>
nnoremap <C-s> :w<CR>
nnoremap <C-n> :belowright terminal ++rows=10 npm start<CR>

nnoremap <C-Right> :tabnext<CR>call ToggleNerdtree()<CR>
nnoremap <C-Left> :tabprevious<CR>call ToggleNerdtree()<CR>

vmap <C-c> "+y
vmap <C-v> <Esc>"+gp

nnoremap <C-q> <C-w><C-w>
tnoremap <C-q> <C-w><C-w>
"nnoremap <leader>n :NERDTreeFocus<CR>
"nnoremap <C-n> :NERDTree<CR>
"nnoremap <C-f> :NERDTreeFind<CR>

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if &buftype != 'quickfix' && getcmdwintype() == '' | silent NERDTreeMirror | endif
let g:NERDTreeFileLines = 1

"Для закрытия текущего буфера (файла): :bd или :bdelete
"Для закрытия текущей вкладки (вместе с буферами): :tabclose или :q

