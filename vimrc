if empty(glob('~/.vim/plugged'))
    autocmd VimEnter * PlugInstall --sync
endif


filetype plugin indent on "Включает определение типа файла, загрузку...
"... соответствующих ему плагинов и файлов отступов
set encoding=utf-8 "Ставит кодировку UTF-8
set nocompatible "Отключает обратную совместимость с Vi
syntax enable "Включает подсветку синтаксиса

call plug#begin('~/.vim/plugged') "Начать искать плагины в этой директории
"Тут будут описаны наши плагины
Plug 'scrooloose/nerdtree'
call plug#end() "Перестать это делать


"свитчи в норм режиме
"открыть закрыть бар
nnoremap <C-b> :NERDTreeToggle<CR>

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-f> :NERDTreeFind<CR>

