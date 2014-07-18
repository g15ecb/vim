"  __________________________________
" /\                                 \
" \_| Granville Barnett's Vim Config |
"   | granvillebarnett@gmail.com     |
"   |   _____________________________|_
"    \_/_______________________________/
 
" the basics
set nocompatible
filetype off " vundle requires this

" Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()


" *****************************************************************************
" Bundles /////////////////////////////////////////////////////////////////////
" https://github.com/gmarik/Vundle.vim ////////////////////////////////////////
" *****************************************************************************
Bundle 'gmarik/Vundle'
Bundle 'mileszs/ack.vim'
Bundle 'bling/vim-airline'
Bundle 'bling/vim-bufferline'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-surround'
Bundle 'kien/ctrlp.vim'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'scrooloose/syntastic'
Bundle 'elixir-lang/vim-elixir'
Bundle 'mattonrails/vim-mix.git'
Bundle 'jimenezrick/vimerl'
Bundle 'wting/rust.vim'
Bundle 'Valloric/YouCompleteMe'
" *****************************************************************************
" /////////////////////////////////////////////////////////////////////////////
" *****************************************************************************

" *****************************************************************************
" Vanilla config //////////////////////////////////////////////////////////////
" *****************************************************************************
set t_Co=256
set ruler "always show current positions along the bottom
set hlsearch
set hidden " lusty explorer
" following three variables make use of spaces instead of tabs
set expandtab
set shiftwidth=2
set softtabstop=2
set nu "show line numbers
set so=20 " some vertical buffering of current buffer 
set ignorecase
set incsearch
set autoindent " just indent on your own!!!!
set vb " visual bell because audible bell pisses me off
set nobackup
set noswapfile
" never go over 80 cols. 
set tw=80
set wrap
" use q to easily format text. I like this from Emacs using M-q
map q gq}
" set current working directory to that of the file being edited
"set autochdir
" show path of file being edited.
set modeline
set ls=2
" show incomplete commands
set showcmd
"set spell
set spelllang=en_gb
set cursorline
"set cursorcolumn
syntax on 
filetype plugin on 
filetype indent on
" Limit popup menu height
set pumheight=15
set completeopt-=preview " don't like it
set background=dark

let mapleader=";" 

" custom mappings
nmap <leader>a :Ack<SPACE>
"nmap <leader>s :VimShell<CR>
nmap <leader>d :bd<CR>
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>
nmap <leader>f :CtrlP<CR>
nmap <leader>b :CtrlPBuffer<CR>
nmap <leader>m :Mix test<CR>
nmap <leader>o :only<CR>
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>

" reload vimrc when tweaked
au bufwritepost .vimrc source $MYVIMRC

" open buffer at pos. where you were last 
au BufReadPost *
\ if line("'\"") > 1 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif 

" Personal preference for tabs in OCaml, Haskell and Rust
au FileType ocaml setlocal sw=2 sts=2 et
au FileType haskell setlocal sw=2 sts=2 et
au FileType rust setlocal sw=2 sts=2 et

" Prohibit annoying LaTeX unicode symbols
au FileType tex setlocal conceallevel=0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
au BufWrite *.ml* :call OcpIndentBuffer()

au BufEnter * :only
" *****************************************************************************
" Vanilla config //////////////////////////////////////////////////////////////
" *****************************************************************************

" *****************************************************************************
" Ocp-indent //////////////////////////////////////////////////////////////////
" NB. installed via opam //////////////////////////////////////////////////////
" https://github.com/OCamlPro/ocp-indent //////////////////////////////////////
" *****************************************************************************
let g:ocp_indent_vimfile = system("opam config var share")
let g:ocp_indent_vimfile = substitute(g:ocp_indent_vimfile, '[\r\n]*$', '', '')
let g:ocp_indent_vimfile = g:ocp_indent_vimfile .  "/vim/syntax/ocp-indent.vim"
au FileType ocaml exec ":source " . g:ocp_indent_vimfile

" *****************************************************************************
" Merlin //////////////////////////////////////////////////////////////////////
" NB. installed via opam //////////////////////////////////////////////////////
" https://github.com/the-lambda-church/merlin /////////////////////////////////
" *****************************************************************************
let s:ocamlmerlin=substitute(system('opam config var share'),'\n$','','''') .  "/ocamlmerlin"
execute "set rtp+=".s:ocamlmerlin."/vim"
execute "set rtp+=".s:ocamlmerlin."/vimbufsync"

" *****************************************************************************
" Rainbow parens //////////////////////////////////////////////////////////////
" https://github.com/kien/rainbow_parentheses.vim /////////////////////////////
" *****************************************************************************
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]


" *****************************************************************************
" Markdown ////////////////////////////////////////////////////////////////////
" https://github.com/plasticboy/vim-markdown //////////////////////////////////
" *****************************************************************************
let g:vim_markdown_folding_disabled=1

" *****************************************************************************
" Solarized ///////////////////////////////////////////////////////////////////
" https://github.com/altercation/vim-colors-solarized /////////////////////////
" *****************************************************************************
colorscheme solarized

" *****************************************************************************
" Gui stuff ///////////////////////////////////////////////////////////////////
" *****************************************************************************
if has('gui_running')
  set guioptions=Ace  
  if has("gui_running")
    if has("gui_gtk2")
      set guifont=Monospace\ 16
    elseif has("gui_macvim")
      set guifont=Monaco:h20
    endif
  endif
endif

au GUIEnter * set t_vb= 

" this is required to make vimerl completion work ;-(
" https://github.com/Valloric/YouCompleteMe/issues/862
let g:ycm_cache_omnifunc = 0
