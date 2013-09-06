
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
"Bundle 'jiangmiao/auto-pairs'
Bundle 'eagletmt/ghcmod-vim'
Bundle 'ujihisa/neco-ghc'
Bundle 'Shougo/vimproc.vim'
Bundle 'wting/rust.vim'
Bundle 'scrooloose/syntastic'
Bundle 'derekwyatt/vim-scala'

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
nmap <leader>r :!rust run %<CR>
nmap <leader>t :!rust test %<CR>
nmap <leader>m :make<CR>
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

    au FileType haskell setlocal sw=2 sts=2 et
    au FileType rust setlocal sw=2 sts=2 et
    au FileType scala setlocal sw=2 sts=2 et

    au FileType ocaml setlocal sw=2 sts=2 et
    au FileType ocaml source /Users/gb/.opam/4.00.1/share/typerex/ocp-indent/ocp-indent.vim
    au BufWrite *.ml call OcpIndentBuffer()

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
let g:neocomplcache_enable_fuzzy_completion=1

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
let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

let g:neocomplcache_fuzzy_completion_start_length=1
let g:neocomplcache_enable_fuzzy_completion=1

if has('gui_running')
    set guifont=Menlo\ for\ Powerline:h24
    set guioptions-=T
    set guioptions-=r
    " Complete options (disable preview scratch window)
    set completeopt=menu,menuone,longest
endif

