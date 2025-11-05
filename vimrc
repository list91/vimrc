" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

" Set leader key to space
let mapleader = "\<Space>"

" Encoding settings for UTF-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp1251,koi8-r,cp866
set termencoding=utf-8

set expandtab
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4


set viminfo+='1000
set viminfo='1000,n~/viminfo

if has('autocmd')
    autocmd BufWinLeave * mkview
    autocmd BufWinEnter * silent loadview
endif



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
"Plug 'vim-scripts/vim-gitgutter'  " Disabled for Windows compatibility
Plug 'morhetz/gruvbox'

Plug 'scrooloose/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dense-analysis/ale'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }

"Plug 'dense-analysis/ale'

"Plug 'Valloric/YouCompleteMe'

Plug 'mg979/vim-visual-multi', {'branch': 'master'}

Plug 'maxmellon/vim-jsx-pretty'
Plug '1995eaton/vim-better-javascript-completion'
call plug#end()


let g:ale_linters = {
 \   'javascript': ['eslint'],
 \}
let g:ale_fixers = {
 \   'javascript': ['eslint'],
 \}

noremap <Leader>y "+y
noremap <Leader>p "+p

let g:airline_theme='wombat'


" Установка цветовой схемы Gruvbox со стилем dark hard
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'

" set shell=sh  " Commented for Windows compatibility
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


let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-d>'           " replace C-n
let g:VM_maps['Find Subword Under'] = '<C-d>'           " replace visual C-n


" Start NERDTree and put the cursor back in the other window.
"autocmd VimEnter * NERDTree
let NERDTreeMinimalUI=1

" Автоматически открывать NERDTree при старте Vim
"autocmd VimEnter * NERDTree
" Открывать NERDTree при запуске Vim без аргументов в текущей директории
autocmd VimEnter * if argc() == 0 | NERDTree | endif

" Отобразить пустое окно при запуске Vim
"autocmd VimEnter * execute 'silent! belowright 10new' | execute 'resize 5'

nnoremap <A-Down> :m+<CR>
nnoremap <A-Up> :m-2<CR>

nnoremap <C-Down> :t .+1<CR>

