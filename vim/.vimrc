" http://files.swaroopch.com/vim/byte_of_vim_v051.pdf
"
"
" function todo()
" python <<EOF
" import vim  # vim py api
" print TODO
" EOF
" endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
" Plugin 'vim-scripts/closetags'
Plugin 'kien/ctrlp.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'tomtom/tlib_vim'   " snipmate
Plugin 'MarcWeber/vim-addon-mw-utils'  " snipmate
Plugin 'garbas/vim-snipmate'  " snipmate
Plugin 'honza/vim-snippets'  " snipmate
Plugin 'vadv/vim-chef'
Plugin 'gregsexton/MatchTag'
Plugin 'vim-ruby/vim-ruby'
Plugin 'kana/vim-textobj-user'
Plugin 'vim-scripts/django-template-textobjects'
Plugin 'scrooloose/nerdtree'
Plugin 'nvie/vim-flake8'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/syntastic'
Bundle "jQuery"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" jedi
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#popup_on_dot = 0
let g:jedi#auto_close_doc = 1
" syntastics
"
let g:syntastic_enable_signs=1
let g:syntastic_auto_jump=1
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'
" checkers
let g:syntastic_python_checkers = ['pyflakes']
" jshint
let g:syntastic_javascript_checkers = ['jshint']
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
"
set pastetoggle=<F2>

map <C-right> <ESC>:bn<CR>
map <C-left> <ESC>:bp<CR>
map _2 :!ctags -R -f ./tags `python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()"`<CR>
" tagbar
nmap <F8> :TagbarToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set viewdir=$HOME/.vim/views
set sessionoptions=folds
set et
" set mouse=a
set nocompatible    " use vim defaults
set ls=2            " allways show status line
set tabstop=4       " numbers of spaces of tab character
set shiftwidth=4    " numbers of spaces to (auto)indent
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
set smartindent
set tags=.tags,tags,.tags_python,.gemtags
set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l,%v--%L\ (%p%%)\ HEX=\%02.2B\ BIN=\%08.8b]
syntax match nonascii "[^\x00-\x7F]"
highlight nonascii guibg=Red ctermbg=2
colorscheme desert
syntax enable


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au FileType ruby set sw=2 ts=2
au FileType javascript set sw=2 ts=2
au FileType html set sw=2 ts=2
" chef
au FileType ruby,eruby set filetype=ruby.eruby.chef
