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
Bundle 'bling/vim-airline'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-surround'
Bundle 'kien/ctrlp.vim'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'plasticboy/vim-markdown'
"Bundle 'Rip-Rip/clang_complete'
Bundle 'scrooloose/syntastic'
"Bundle 'Shougo/neocomplcache'
"Bundle 'Shougo/neosnippet'
Bundle 'Shougo/vimproc.vim'
Bundle 'Shougo/vimshell.vim'
Bundle 'eagletmt/ghcmod-vim'
Bundle "eagletmt/neco-ghc"
Bundle 'dag/vim2hs'
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

imap jk <Esc>
let mapleader=";" 

" custom mappings
nmap <leader>a :Ack<SPACE>
nmap <leader>s :VimShell<CR>
nmap <leader>d :bd<CR>
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>
nmap <leader>f :CtrlP<CR>
nmap <leader>b :CtrlPBuffer<CR>
nmap <leader>m :!make<CR>
nmap <leader>o :only<CR>
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <leader>p :%!stylish-haskell<CR>

" reload vimrc when tweaked
au bufwritepost .vimrc source $MYVIMRC

" open buffer at pos. where you were last 
au BufReadPost *
\ if line("'\"") > 1 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif 

au FileType ocaml setlocal sw=2 sts=2 et
au FileType haskell setlocal sw=2 sts=2 et
au FileType rust setlocal sw=2 sts=2 et
au FileType scala setlocal sw=2 sts=2 et

" the following due to annoying LaTeX unicode symbols
au FileType tex setlocal conceallevel=0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

au BufEnter * :only
" *****************************************************************************
" /////////////////////////////////////////////////////////////////////////////
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
" Neocomplache ////////////////////////////////////////////////////////////////
" https://github.com/Shougo/neocomplcache.vim /////////////////////////////////
" *****************************************************************************
" Launches neocomplcache automatically on vim startup.
"let g:neocomplcache_enable_at_startup = 1
"" Use smartcase.
"let g:neocomplcache_enable_smart_case = 1
"" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
"" Use underscore completion.
"let g:neocomplcache_enable_underbar_completion = 1
"" Sets minimum char length of syntax keyword.
"let g:neocomplcache_min_syntax_length = 3
"" buffer file name pattern that locks neocomplcache. e.g. ku.vim or
"" fuzzyfinder 
"let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
"let g:neocomplcache_enable_fuzzy_completion=1
"let g:neocomplcache_enable_fuzzy_completion=1
"
"" Need to force completion engine upon certain char seqs
"if !exists('g:neocomplcache_force_omni_patterns')
"    let g:neocomplcache_force_omni_patterns = {}
"endif
"let g:neocomplcache_force_overwrite_completefunc = 1
"let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"let g:neocomplcache_force_omni_patterns.ocaml = '[^. *\t]\.\w*\|\h\w*|#'
" *****************************************************************************
" /////////////////////////////////////////////////////////////////////////////
" *****************************************************************************

" *****************************************************************************
" Clang complete //////////////////////////////////////////////////////////////
" https://github.com/Rip-Rip/clang_complete ///////////////////////////////////
" *****************************************************************************
"let g:clang_complete_auto = 0
"let g:clang_auto_select = 0
"let g:clang_use_library = 1
"let g:clang_library_path="/usr/lib/llvm-3.4/lib"
"let g:clang_library_path="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib"

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
" Haskell /////////////////////////////////////////////////////////////////////
" https://github.com/dag/vim2hs ///////////////////////////////////////////////
" *****************************************************************************
let g:haskell_conceal = 0
let g:haskell_conceal_enumerations = 0

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

