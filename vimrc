" Vim config
" granvillebarnett@gmail.com
"
" Prerequisites: 
"
" - libclang 
" - clang-format 
"
" You will need to adjust the respective variables for the clang_complete and
" clang-format sections to point to the necessary library/binary.
 
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
"Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-completer' }
Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'
Plug 'kien/ctrlp.vim'
Plug 'junegunn/seoul256.vim'
Plug 'rhysd/vim-clang-format'
Plug 'asciidoc/vim-asciidoc'
Plug 'Lokaltog/vim-easymotion'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/vimshell.vim'
Plug 'Shougo/unite-outline'
Plug 'Shougo/unite.vim'
Plug 'aklt/plantuml-syntax'

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
nmap <leader>s :VimShell<CR>
nmap <leader>f :CtrlP<CR>
nmap <leader>b :CtrlPBuffer<CR>
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
"au VimEnter * RainbowParenthesesToggle
"au Syntax * RainbowParenthesesLoadRound
"au Syntax * RainbowParenthesesLoadSquare
"au Syntax * RainbowParenthesesLoadBraces
au BufEnter * :only

let g:load_doxygen_syntax=1

" *****************************************************************************
" Markdown ////////////////////////////////////////////////////////////////////
" https://github.com/plasticboy/vim-markdown //////////////////////////////////
" *****************************************************************************
let g:vim_markdown_folding_disabled=1

" *****************************************************************************
" vim-clang-format ////////////////////////////////////////////////////////////
" https://github.com/rhysd/vim-clang-format ///////////////////////////////////
" *****************************************************************************
let g:clang_format#command="clang-format"
let g:clang_format#auto_format=1
let g:clang_format#code_style="google" " 

" *****************************************************************************
" syntastic ///////////////////////////////////////////////////////////////////
" https://github.com/scrooloose/syntastic /////////////////////////////////////
" *****************************************************************************
" let g:syntastic_cpp_compiler = 'clang++'
" let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

" *****************************************************************************
" neocomplete /////////////////////////////////////////////////////////////////
" https://github.com/Shougo/neocomplete ///////////////////////////////////////
" *****************************************************************************
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" *****************************************************************************
" seoul256 ////////////////////////////////////////////////////////////////////
" https://github.com/junegunn/seoul256.vim ////////////////////////////////////
" *****************************************************************************
let g:seoul256_background = 233
colorscheme seoul256

" Asciidoc
au BufRead,BufNewFile *.adoc set filetype=asciidoc

imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" *****************************************************************************
" " Gui stuff
" ///////////////////////////////////////////////////////////////////
" "
" *****************************************************************************
if has('gui_running')
  set guioptions=Ace  
  if has("gui_running")
    if has("gui_gtk2")
      set guifont=Monospace\ 20
    elseif has("gui_macvim")
      set guifont=Monaco:h24
    endif
  endif
endif

au GUIEnter * set t_vb= 
