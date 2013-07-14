
" the basics
set nocompatible
filetype off " vundle requires this

" Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" Bundles
Bundle 'mileszs/ack.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'Lokaltog/vim-powerline'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neosnippet'
Bundle 'Rip-Rip/clang_complete'
Bundle 'kien/ctrlp.vim'
Bundle 'vim-ruby/vim-ruby'
Bundle "jiangmiao/auto-pairs"
Bundle "myusuf3/numbers.vim"

" UI
Bundle 'altercation/vim-colors-solarized'
Bundle 'stephenmckinney/vim-solarized-powerline'
 
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
syntax on 
filetype plugin on 
filetype indent on
" Limit popup menu height
set pumheight=15
set completeopt-=preview " don't like it
"set conceallevel=0 " get rid of annoying conceal unicode symbs in TeX!

imap jk <Esc>

let mapleader=";" 
" some custom mappings
nmap <leader>a :Ack<CR>
nmap <leader>s :Ack<SPACE>
map <leader>d :bd<CR>
nmap <leader>d :bd<CR>
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>
nmap <leader>f :CtrlP<CR>
nmap <leader>b :CtrlPBuffer<CR>
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>

if has("autocmd")
    " reload vimrc when tweaked
    au bufwritepost .vimrc source $MYVIMRC

    " open buffer at pos. where you were last 
    au BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif 

    " the following due to annoying LaTeX unicode symbols
    au FileType tex setlocal conceallevel=0

endif

" 3rd Party plugins -----------------------------------------------------------
let g:Powerline_symbols = 'fancy'

" make ack use ag
let g:ackprg = 'ag --nogroup --nocolor --column'

" clang
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_use_library = 1

" necoghc
"let g:necoghc_enable_detailed_browse = 1

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

autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
"autocmd FileType go setlocal omnifunc=gocomplete#Complete

" the below config for clang_complete I got from:
" http://stackoverflow.com/questions/12975098/using-neocomplcache-and-clang-complete
if !exists('g:neocomplcache_force_omni_patterns')
    let g:neocomplcache_force_omni_patterns = {}
endif

" https://github.com/davidhalter/jedi-vim/issues/26
let g:jedi#auto_initialization = 1
let g:jedi#popup_on_dot = 0
let g:jedi#show_function_definition = "0"
autocmd  FileType python let b:did_ftplugin = 1

let g:neocomplcache_force_overwrite_completefunc = 1
let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplcache_force_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"let g:neocomplcache_force_omni_patterns.go = '\h\w*\%.'

" END neocomplcache settings **************************************************

if has('gui_running')
    set guifont=Menlo\ for\ Powerline:h24
    set guioptions-=T
    set guioptions-=r
    " Complete options (disable preview scratch window)
    set completeopt=menu,menuone,longest

endif

set background=dark
colorscheme solarized

let g:Powerline_theme='short'
let g:Powerline_colorscheme='solarized256_dark'

set cursorline
