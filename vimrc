" Vim config
" granvillebarnett@gmail.com
 
" the basics
set nocompatible
filetype off " vundle requires this

" *****************************************************************************
" Plugins /////////////////////////////////////////////////////////////////////
" https://github.com/junegunn/vim-plug ////////////////////////////////////////
" *****************************************************************************
call plug#begin('~/.vim/plugged')

Plug 'bling/vim-airline'
Plug 'bling/vim-bufferline'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'kien/rainbow_parentheses.vim'
Plug 'scrooloose/syntastic'
Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Rip-Rip/clang_complete'
Plug 'junegunn/seoul256.vim'
Plug 'fatih/vim-go'

call plug#end()
" *****************************************************************************
" /////////////////////////////////////////////////////////////////////////////
" *****************************************************************************

" *****************************************************************************
" /////////////////////////////// BASIC STUFFF ////////////////////////////////
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
" set autochdir
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
nmap <leader>d :bd<CR>
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>
nmap <leader>f :Unite file_rec/async<CR>
nmap <leader>b :Unite -quick-match buffer<CR>
nmap <leader>s :Unite grep:.<CR>
nmap <leader>m :make<CR>
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

au FileType tex setlocal conceallevel=0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
au BufEnter * :only

" *****************************************************************************
" ////////////////////////////////// OCAML ////////////////////////////////////
" *****************************************************************************
au FileType ocaml setlocal sw=2 sts=2 et

" *****************************************************************************
" Ocp-indent //////////////////////////////////////////////////////////////////
" NB. installed via opam //////////////////////////////////////////////////////
" https://github.com/OCamlPro/ocp-indent //////////////////////////////////////
" *****************************************************************************
"execute ":source ".g:oi 
"source $HOME/.opam/4.02.0/share/vim/syntax/ocp-indent.vim
"au BufWrite *.ml* :call OcpIndentBuffer()

" *****************************************************************************
" Merlin //////////////////////////////////////////////////////////////////////
" NB. installed via opam //////////////////////////////////////////////////////
" https://github.com/the-lambda-church/merlin /////////////////////////////////
" *****************************************************************************
"set rtp+=$HOME/.opam/4.02.0/share/merlin/vim

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
" neocomplete /////////////////////////////////////////////////////////////////
" https://github.com/Shougo/neocomplete.vim ///////////////////////////////////
" *****************************************************************************
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" dictionary
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }
" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
" Recommended key-mappings.
" " <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#force_omni_input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
let g:neocomplete#force_omni_input_patterns.objc = '\[\h\w*\s\h\?\|\h\w*\%(\.\|->\)'
let g:neocomplete#force_omni_input_patterns.objcpp = '\[\h\w*\s\h\?\|\h\w*\%(\.\|->\)\|\h\w*::\w*'
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_use_library = 1

let g:seoul256_background = 233
colorscheme seoul256
