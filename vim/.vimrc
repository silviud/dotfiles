"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" alternatively, pass a path where Vundle should install plugins
"let path = '~/some/path/here'
"call vundle#rc(path)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'gmarik/vundle'  " required by vundle
Plugin 'tpope/vim-fugitive'
Plugin 'kien/ctrlp.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'gregsexton/MatchTag'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/syntastic'
Plugin 'Shougo/neocomplcache.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'scrooloose/nerdcommenter'
Bundle 'flazz/vim-colorschemes'
Bundle 'majutsushi/tagbar'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
" Plugin 'vim-scripts/closetags'
" Plugin 'nvie/vim-flake8'
" Plugin 'tmhedberg/SimpylFold'
" Bundle 'https://github.com/neilagabriel/vim-geeknote'
" Bundle 'ntpeters/vim-better-whitespace' TODO
" Bundle 'jQuery'
" Plugin 'tomtom/tlib_vim'   " snipmate
" Plugin 'MarcWeber/vim-addon-mw-utils'  " snipmate
" Plugin 'garbas/vim-snipmate'  " snipmate
" Plugin 'honza/vim-snippets'  " snipmate
" Plugin 'vadv/vim-chef'
" Plugin 'vim-ruby/vim-ruby'
" Plugin 'kana/vim-textobj-user'
" Plugin 'vim-scripts/django-template-textobjects'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" jedi
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#popup_on_dot = 0
let g:jedi#auto_close_doc = 1
" slow in venv
let g:pymode_rope = 0
let g:pymode_folding = 0
" syntastics
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_python_checkers = ['flake8']
"
autocmd BufReadPre *.js let b:javascript_lib_use_jquery = 1
au BufRead,BufNewFile *.ejs set filetype=javascript
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" paste
function! IndentPasteOff()
  set noai nocin nosi inde=
endfunction

function! IndentPasteOn()
  set ai cin si
endfunction

nmap _0  :call IndentPasteOff()<CR> 
nmap _1  :call IndentPasteOn()<CR> 

" paste with indent
nnoremap <C-\> :set invpaste paste?<CR>
set pastetoggle=<C-\>
set showmode

" javascript
command! UnMinify call UnMinify()
function! UnMinify()
    %s/{\ze[^\r\n]/{\r/g
    %s/){/) {/g
    %s/};\?\ze[^\r\n]/\0\r/g
    %s/;\ze[^\r\n]/;\r/g
    %s/[^\s]\zs[=&|]\+\ze[^\s]/ \0 /g
    normal ggVG=
endfunction
"
" set pastetoggle=<F2>

map <C-right> <ESC>:bn<CR>
map <C-left> <ESC>:bp<CR>
map _2 :!ctags -R -f ./tags `python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()"`<CR>
" tagbar
nmap <F8> :TagbarToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable
set viewdir=$HOME/.vim/views
set sessionoptions=folds
" set mouse=a
set nocompatible    " use vim defaults
set ls=2            " allways show status line
set scrolloff=3     " keep 3 lines when scrolling
set showcmd         " display incomplete commands
set hlsearch        " highlight searches
set incsearch       " do incremental searching
set ruler           " show the cursor position all the time
set laststatus=2
set visualbell t_vb=    " turn off error beep/flash
set novisualbell    " turn off visual bell
set nobackup        " do not keep a backup file
set number          " show line numbers
set numberwidth=4   " line numbering takes up 5 spaces
set ignorecase      " ignore case when searching
set nowrap          " stop lines from wrapping
set noignorecase   " don't ignore case
set notitle         " don't show "Thanks for flying vim"
set ttyfast         " smoother changes
set ttyscroll=0        " turn off scrolling, didn't work well with PuTTY
set bs=2            " Backspace can delete previous characters
set modeline        " last lines in document sets vim mode
set modelines=3     " number lines checked for modelines
set shortmess=atI   " Abbreviate messages
set nostartofline   " don't jump to first character when paging
set whichwrap=b,s,h,l,<,>,[,]   " move freely between files
set undolevels=200
set cpoptions=$cF
set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc,*.DS_Store,*.db
set tags=.tags,tags,.tags_python,.gemtags
set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l,%v--%L\ (%p%%)\ HEX=\%02.2B\ BIN=\%08.8b]
" syntastics
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set wildmenu
set cursorline
" folding
set foldenable
"set foldlevelstart=1
set foldlevel=1
"set foldnestmax=10
set foldmethod=manual
" configure expanding of tabs for various file types
au BufRead,BufNewFile *.c set noexpandtab
au BufRead,BufNewFile *.h set noexpandtab
au BufRead,BufNewFile Makefile* set noexpandtab

" --------------------------------------------------------------------------------
set expandtab           " enter spaces when tab is pressed
set textwidth=120       " break lines when line length increases
set tabstop=4           " use 4 spaces to represent tab
set softtabstop=4
set shiftwidth=4        " number of spaces to use for auto indent
set autoindent          " copy indent from current line when starting a new line
set smartindent

" terminal install ncurses-term
" bashrc  export TERM=xterm-256color
colorscheme xoria256
" cursor line
hi CursorLine   cterm=NONE ctermbg=232 ctermfg=white guibg=darkred guifg=white
hi CursorColumn cterm=NONE ctermbg=232 ctermfg=white guibg=darkred guifg=white
nnoremap <Leader>c :set cursorline! <CR>
nnoremap <Leader>CC :set cursorcolumn!<CR>
nnoremap <space> za


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au FileType ruby set sw=2 ts=2
" au FileType javascript set sw=2 ts=2
" au FileType html set sw=2 ts=2
" chef
au FileType ruby,eruby set filetype=ruby.eruby.chef

au BufRead,BufNewFile *.pt set filetype=html
au FileType html set sw=2 ts=2 smartindent 

" neocomplcache
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" linting python - choosed syntastic
" autocmd FileType python set makeprg=pylint\ --reports=n\ --msg-template=\"{path}:{line}:\ {msg_id}\ {symbol},\ {obj}\ {msg}\"\ %:p
" autocmd FileType python set errorformat=%f:%l:\ %m
