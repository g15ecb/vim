" the basics
set nocompatible
filetype off " vundle requires this

" Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" Bundles
Bundle 'derekwyatt/vim-scala'
Bundle 'mileszs/ack.vim'
Bundle 'tpope/vim-commentary'
Bundle 'sjbach/lusty'
Bundle 'Lokaltog/vim-powerline'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/syntastic'
" Bundle 'kien/rainbow_parentheses.vim'
Bundle 'tpope/vim-surround'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neosnippet'
Bundle 'Rip-Rip/clang_complete'
Bundle 'johnsyweb/vim-makeshift'
" Bundle 'vim-easymotion'
Bundle 'elixir-lang/vim-elixir'
Bundle 'oscarh/vimerl'
Bundle 'JesseKPhillips/d.vim'
"Bundle 'wincent/Command-T'

" gvim settings
if has('gui_running')
    set guifont=Menlo\ for\ Powerline:h24
    set guioptions-=T
    set guioptions-=r
    " Complete options (disable preview scratch window)
    set completeopt=menu,menuone,longest
    colorscheme macvim
    " use scalac in gvim
    au BufWritePost *.scala !scalac % 
else
    set t_Co=256 " needs a terminal capable of 256 colors
endif

" vanilla settings
set ruler "always show current positions along the bottom
set hlsearch
set hidden " lusty explorer
" following three variables make use of spaces instead of tabs
set expandtab
set shiftwidth=4
set softtabstop=4
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
set autochdir
" show path of file being edited.
set modeline
set ls=2
" show incomplete commands
set showcmd
"set spell
set spelllang=en_gb
" plugins, etc.
syntax on filetype plugin indent on filetype indent on
" Limit popup menu height
set pumheight=15
set completeopt-=preview " don't like it

let mapleader=";" 
" some custom mappings
nmap <leader>a :Ack<CR>
nmap <leader>s :Ack<SPACE>
nmap <leader>n :make<CR>
nmap <leader>d :bd<CR>
nmap <leader>c :close<CR>
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
" k and j are movement for logical rather than hard lines, i.e.
" they consider soft lines a line as well
nmap k gk 
nmap j gj 


" jj as alias for esc in insert mode and jj for alias of c-c in command mode
ino jj <esc> 
cno jj <c-c>


" Clang (NB. need Vim with python support for libclang)
" let g:clang_snippets=1 */
" if clang_complete_auto is 0 then it will supress completion after ., :: and ->
" let g:clang_complete_auto = 0 Show clang errors in the quickfix window (set to
" 0 to switch off)
" let g:clang_complete_copen = 1 let g:clang_close_preview = 1 let
" g:clang_use_library = 1

" I should really but all au's in here, but gvim is safe
" auto commands
if has("autocmd")
    " reload vimrc when tweaked
    au bufwritepost .vimrc source $MYVIMRC

    " open buffer at pos. where you were last 
    au BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif 

    " compile and run d program on save
    au BufWritePost *.d !rdmd -unittest % 
endif

" 3rd Party plugins -----------------------------------------------------------
let g:Powerline_symbols = 'fancy'

" make ack use ag
let g:ackprg = 'ag --nogroup --nocolor --column'

" scons and python
autocmd BufReadPre SConstruct set filetype=python
autocmd BufReadPre SConscript set filetype=python

" START neocomplcache settings ************************************************
" Disable AutoComplPop. Comment out this line if AutoComplPop is not installed.
let g:acp_enableAtStartup = 0
" Launches neocomplcache automatically on vim startup.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underscore completion.
let g:neocomplcache_enable_underbar_completion = 1
" Sets minimum char length of syntax keyword.
let g:neocomplcache_min_syntax_length = 3
" buffer file name pattern that locks neocomplcache. e.g. ku.vim or
" fuzzyfinder 
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" neosnippet
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
    set conceallevel=2 concealcursor=i
endif

" the below config for clang_complete I got from:
" http://stackoverflow.com/questions/12975098/using-neocomplcache-and-clang-complete
if !exists('g:neocomplcache_force_omni_patterns')
    let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_overwrite_completefunc = 1
let g:neocomplcache_force_omni_patterns.c =
    \ '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp =
    \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplcache_force_omni_patterns.objc =
    \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplcache_force_omni_patterns.objcpp =
    \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_use_library = 1

autocmd FileType python setlocal omnifunc=pythoncomplete#Complete

" END neocomplcache settings **************************************************

