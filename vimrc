"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
"       r12f
"       http://bigasp.com - r12f.code@gmail.com
"
" Description:
" This vimrc is based on Amix's vimrc(http://amix.dk/vim/vimrc.html).
"
" Sections:
"    -> General
"    -> Vundle: plugin management
"    -> VIM user interface
"    -> Encoding
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> General IDE settings
"    -> IDE for vimrc
"    -> IDE for Go
"    -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible                            " No compatible with VI
set history=700                             " Sets how many lines of history VIM has to remember
set autoread                                " Set to auto read when a file is changed from the outside
let mapleader=","                           " With a map leader it's possible to do extra key combinations
let g:mapleader=","                         " With a map leader it's possible to do extra key combinations

function! MySys()
    if has("win32")
        return "windows"
    elseif has("mac") || has("macunix")
        return "mac"
    else
        return "linux"
    endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle: plugin management
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off

if MySys() == "windows"
    set rtp+=~/vimfiles/bundle/Vundle.vim/
    let path='~/vimfiles/bundle'
    call vundle#begin(path)
else
    set rtp+=~/.vim/bundle/Vundle.vim/
    call vundle#begin()
endif

Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'majutsushi/tagbar'
" Temporarily disable vim-airline, because of serious performance degradation during startup.
" Plugin 'bling/vim-airline'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'Yggdroot/indentLine'
Plugin 'fatih/vim-go'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'mattn/emmet-vim'
Plugin 'PProvost/vim-ps1'

call vundle#end()

filetype plugin on
filetype indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM user interface
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set so=7                                    " Set 7 lines to the cursor - when moving vertically using j/k
set wildmenu                                " Turn on the WiLd menu
set wildignore=*.o,*~,*.pyc                 " Ignore compiled files
set ruler                                   " Always show current position
set number                                  " Turn on line number
set cmdheight=2                             " Height of the command bar
set hid                                     " A buffer becomes hidden when it is abandoned
set backspace=eol,start,indent              " Configure backspace so it acts as it should act
set whichwrap+=<,>,h,l                      " Configure backspace so it acts as it should act
set ignorecase                              " Ignore case when searching
set smartcase                               " When searching try to be smart about cases
set hlsearch                                " Highlight search results
set incsearch                               " Makes search act like search in modern browsers
set lazyredraw                              " Don't redraw while executing macros (good performance config)
set magic                                   " For regular expressions turn magic on
set showmatch                               " Show matching brackets when text indicator is over them
set mat=2                                   " How many tenths of a second to blink when matching brackets
set noerrorbells                            " No annoying sound on errors
set novisualbell                            " No annoying sound on errors
set t_vb=                                   " No annoying sound on errors
set tm=500                                  " Set timeout time to 500ms

if has("gui_running")
    set guioptions-=T                       " No toolbar
    set guioptions-=m                       " No menu
    set guioptions-=r                       " No right-hand scroll bar
    set guioptions+=e                       " Add tab bar
    set t_Co=256                            " Use 256 color
    set guitablabel=%M\ %t
    set cursorline                          " Highlight cursor line
    if MySys() == 'windows'
        au GUIEnter * simalt ~x             " Auto maximize when enter the gvim
    endif
endif

syntax on                                   " Enable syntax highlighting
colorscheme wombat                          " Set theme

if MySys() == 'windows'
    set guifont=YaHei_Mono:h10cANSI         " Font: YaHei Mono
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File types
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufReadPost *.htm syntax on              " Fixing syntax highlighting when sometimes unable to enable it automatically

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Encoding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set encoding
if has("multi_byte")
    "set bomb
    set encoding=utf-8
    set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,sjis,euc-kr,ucs-2le,latin1
    " CJK environment detection and corresponding setting
    if v:lang =~ "^zh_CN"
        " Use cp936 to support GBK, euc-cn == gb2312
        set encoding=chinese
        set termencoding=chinese
        set fileencoding=chinese
    elseif v:lang =~ "^zh_TW"
        " cp950, big5 or euc-tw
        " Are they equal to each other?
        set encoding=taiwan
        set termencoding=taiwan
        set fileencoding=taiwan
    endif
    " Detect UTF-8 locale, and replace CJK setting if needed
    if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
        set encoding=utf-8
        set termencoding=utf-8
        set fileencoding=utf-8
    endif
endif

" Set favourite file format
if MySys() == 'windows'
    set ffs=dos,unix
else
    set ffs=unix,dos
endif

" if MySys() == 'windows'
"     set ffs=dos,unix,mac
" elseif if MySys() == 'linux'
"     set ffs=unix,dos,mac
" endif

nmap <leader>fd :set ff=dos<cr>
nmap <leader>fu :set ff=unix<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files, backups and undo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup                        " Turn backup off
set nowb                            " Turn backup off
set noswapfile                      " Turn swap file off

" Fast saving
nmap <leader>w :w!<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text, tab and indent related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab                       " Use spaces instead of tabs
set smarttab                        " Be smart when using tabs ;)
set shiftwidth=4                    " 1 tab == 4 spaces
set tabstop=4                       " 1 tab == 4 spaces
set lbr                             " Turn one line break
set tw=500                          " Line break on 500 characters
set ai                              " Auto indent
set si                              " Smart indent
set wrap                            " Wrap lines

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual mode related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving around, tabs, windows and buffers
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

""""""""""""""""""""""""""""""
" Status line
""""""""""""""""""""""""""""""
set laststatus=2                                                                                " Always show the status line
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l              " Format the status line

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if MySys() == 'mac'
    nmap <D-j> <M-j>
    nmap <D-k> <M-k>
    vmap <D-j> <M-j>
    vmap <D-k> <M-k>
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vimgrep searching and cope displaying
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>

" Open vimgrep and put the cursor in the right position
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

" Vimgreps in the current file
map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with vimgrep, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Spell checking
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scripbble
map <leader>q :e ~/buffer<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General IDE settings
"
" Related plugins:
" - 'scrooloose/nerdtree'
" - 'Yggdroot/indentLine'
" - 'majutsushi/tagbar'
" - 'kien/rainbow_parentheses.vim'
" - 'SirVer/ultisnips'
" - 'honza/vim-snippets'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufWrite * :call DeleteTrailingWS()                     " Remove trailing white spaces for all types of files

" NERD Tree
nmap <leader>nt :NERDTreeToggle<CR>
let NERDTreeShowBookmarks=1                                     " Show the NERD tree bookmark

" Indent line
let g:indentLine_color_term = 239                               " Set indent line color in terminal
let g:indentLine_color_gui = '#333333'                          " Set indent line color in gui
let g:indentLine_char = '|'                                     " Set indent line char

" Rainbow parentheses
au VimEnter * RainbowParenthesesToggle                          " Enable the rainbow parentheses
au Syntax * RainbowParenthesesLoadRound                         " Enable for ()
au Syntax * RainbowParenthesesLoadSquare                        " Enable for []
au Syntax * RainbowParenthesesLoadBraces                        " Enable for {}
au Syntax * RainbowParenthesesLoadChevrons                      " Enable for <>

" Tagbar
let g:tagbar_width = 30                                         " Tagbar width
let g:tagbar_expand = 1                                         " Expand the tags
nmap <leader>tb :TagbarToggle<CR>

" Utimate Snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"                             " :UltiSnipsEdit will split window.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" IDE for vimrc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if MySys() == 'windows'
    nmap <leader>rc :e ~/_vimrc<cr>
    autocmd! bufwritepost _vimrc source ~/_vimrc
    autocmd! BufEnter _vimrc :TagbarOpen
else
    nmap <leader>rc :e ~/.vimrc<cr>
    autocmd! bufwritepost .vimrc source ~/.vimrc
    autocmd! BufEnter .vimrc :TagbarOpen
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" IDE for Go
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd! BufEnter *.go :TagbarOpen

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Helper functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo:echo has("python")
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" Delete trailing white space on save
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
