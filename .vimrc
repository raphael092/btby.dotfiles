" lightline
if !has('gui_running')
  set t_Co=256
endif

let g:lightline = {
      \ 'colorscheme': 'one',
      \ }

" vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'scrooloose/nerdtree'
Plug 'benmills/vimux'
Plug 'lervag/vimtex'
Plug 'itchyny/lightline.vim'
Plug 'chriskempson/base16-vim'
Plug 'cespare/vim-toml'
Plug 'mattn/emmet-vim'
Plug 'plasticboy/vim-markdown'
Plug 'othree/html5.vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'
Plug 'csscomb/vim-csscomb'


call plug#end()

set number
