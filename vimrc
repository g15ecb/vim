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
Bundle 'Rip-Rip/clang_complete'
Bundle 'tpope/vim-commentary'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'LaTeX-Box-Team/LaTeX-Box'
Bundle 'sjbach/lusty'
Bundle 'Lokaltog/vim-powerline'
" Bundle 'tsaleh/vim-supertab'
" Bundle 'SirVer/ultisnips'
Bundle 'Lokaltog/TagHighlight'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-endwise'
Bundle 'alexrp/d.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neosnippet'

" vanilla gvim settings
if has('gui_running')
    set guifont=Menlo\ for\ Powerline:h24
    set guioptions-=T
    set guioptions-=r
    " Complete options (disable preview scratch window)
    set completeopt=menu,menuone,longest
    colorscheme macvim
    au BufWritePost *.scala !scala % 
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
set so=8 " always vertically align screen
set ignorecase
set incsearch
set autoindent " just indent on your own!!!!
set vb " visual bell because audible bell pisses me off
"set ch=2 " modeline two lines high
set nobackup
set noswapfile

" never go over 80 cols. 
set tw=80
set wrap
" use q to easily format text
map q gq}

" set current working directory to that of the file being edited
set autochdir
" show path of file being edited.
set modeline
set ls=2

" show incomplete commands
set showcmd

let mapleader=";" " beacuse it's easier to get to

" some custom mappings
nmap <leader>n :make<CR>
nmap <leader>d :bd<CR>
nmap <leader>c :close<CR>
nmap <leader>w :w<CR>

" spelling
"set spell
set spelllang=en_gb

" jj as alias for esc in insert mode and jj for alias of c-c in command mode
ino jj <esc>
cno jj <c-c>

" plugins, etc.
syntax on
filetype plugin indent on
filetype indent on

" Clang (NB. need Vim with python support for libclang)
let g:clang_snippets=1
" if clang_complete_auto is 0 then it will supress completion after ., :: and ->
" let g:clang_complete_auto = 0
" Show clang errors in the quickfix window (set to 0 to switch off)
let g:clang_complete_copen = 1
let g:clang_close_preview = 1
let g:clang_use_library = 1

" Limit popup menu height
set pumheight=15
" SuperTab option for context aware completion
let g:SuperTabDefaultCompletionType = "context"

" auto commands
if has("autocmd")
    " reload vimrc when tweaked
    au bufwritepost .vimrc source $MYVIMRC

    " start where I left off
    au BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif 
endif

let g:Powerline_symbols = 'fancy'

set completeopt-=preview

" let g:SuperTabDefaultCompletionType = 'context'
" let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
" let g:SuperTabLongestHighlight = 1

" make ack use ag
let g:ackprg = 'ag --nogroup --nocolor --column'

nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>

" compile and run d program on save
au BufWritePost *.d !rdmd % 

" neocomplcache settings...
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
