# This is a work in progress vimrc file. I am tweaking it over time to get it to work for me properly in VIM.


filetype off
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

set nocompatible

set viminfo^=!

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

map <silent> <m-p> :cp <cr>
map <silent> <m-n> :cn <cr>

syntax enable
syntax on

set cf
set clipboard+=unnamed
set hidden
set number
set vb t_vb=
set ts=2 sts=2 sw=2 expandtab
set history=1000
set autowrite
set ruler
set nu
set nowrap
set timeoutlen=250


if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

set background=dark
colorscheme solarized

let mapleader = ","
nmap <leader>v :tabedit $MYVIMRC<CR>
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>

nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv