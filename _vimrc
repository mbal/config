" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

filetype off
call pathogen#infect("C:\\Users\\Utente\\bundle")
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

filetype on
filetype plugin on
filetype indent on
syntax on

" === General VIM options ===
set shortmess+=atI "no message on startup
set history=500		" keep 500 lines of command line history
set showmode "always show what mode we're currently editing in.
"Allow backspacing over everything in insert mode
set backspace=indent,eol,start
set ruler		" show the cursor position all the time
set number		" show line number
set showcmd		" display incomplete commands
set wildmenu
set wildignore=*.exe,*.o,*.pyc,*.dll,*.class "Ignore compiled files
set cmdheight=1		"Height of the command bar
set showmatch		"Show matching brackets when text indicator is on
set mat=5		"How many 1/10 of seconds blink when matching brackets
set so=5 " Keep 5 lines from bottom/top
set laststatus=2
set synmaxcol=500 " don't highlight lines longer than 1000 character
set noswapfile
set autoread "autoreload file when changed
set iskeyword+=_ " _ is not a word divider
set lazyredraw " Do not redraw when executing macros
set fo=tcrqn
set nobackup
set autochdir "switch directory to the current file's
set hidden "bdelete hids a buffer
set listchars=tab:>-,trail:·,eol:$

" === Text, tab and indent ===
set expandtab "Use spaces instead of tabs
set smarttab
set shiftwidth=4 "1 tab == 4 spaces
set tabstop=4

set ai " Autoindent
set si " smart indent

" === Search options ===
set incsearch		" do incremental searching
set hlsearch
set ignorecase
set smartcase "only match case when an upper case letter is in the regex

" === UI, font, cursor highlighting ===
"" Bigger window than default
set lines=35 
set columns=84 "" 80 chars + line numbers

set mouse=a "enable mouse (I use gVim)
set guioptions-=T
colorscheme xoria256 "wombat256 

if has("gui_running")
    if has("gui_gtk2")
        set guifont=Inconsolata\ 12
    elseif has("gui_win32")
        set guifont=Consolas:h10:cANSI
    endif
endif

set cul
hi CursorLine term=none cterm=none ctermbg=3

""Turn off error bells
set noerrorbells
set visualbell
set t_vb=

" === Autocommands on filetype
"<F5> to execute current python source (both command and insert mode)
autocmd filetype python noremap <buffer> <F5> :w<CR>:!python %<CR>
autocmd filetype python inoremap <buffer> <F5> <Esc> :w<CR>:!python %<CR>
autocmd filetype python setlocal textwidth=78 "Force the text at 78 colums
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete

autocmd FileType * setlocal colorcolumn=0
autocmd FileType ruby,python,javascript,c,cpp,objc setlocal colorcolumn=79
autocmd FileType text setlocal textwidth=80

augroup EclimJavaCommands
    autocmd!
    autocmd FileType java nnoremap <buffer> <leader>i :JavaImport<CR>
    autocmd FileType java nnoremap <buffer> <leader>d :JavaDocSearch -x declarations<CR>
    autocmd FileType java nnoremap <cr> :JavaSearchContext<CR>
augroup END

" Autocompletion
set completeopt=menuone,longest,preview
let g:SuperTabDefaultCompletionType = 'context'

" === Key mappings ===
let mapleader = ","
let g:mapleader = ","
nnoremap <leader>ev :edit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>nl :nohl<CR>
nnoremap <leader>1 :call RotateTheme()<CR>
nnoremap <silent> <leader>ls :set nolist!<CR>

"" swap ` with ' and viceversa
nnoremap ' `
nnoremap ` '

nnoremap <leader>rn :call NumberToggle()<CR>
nnoremap <F2> :call NumberToggle()<CR>

let s:index = 0
function! RotateTheme()
    let custom_colors = ["Tomorrow-night", "wombat256", "solarized", "xoria256"]
    let s:index = (s:index + 1) % len(custom_colors)
    execute 'colorscheme '.custom_colors[s:index]
endfunction

function! NumberToggle()
    if &relativenumber==1
        set number
    else
        set relativenumber
    endif
endfunction


" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

onoremap in( :<c-u>normal! f(vi(<cr>

if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END
endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
