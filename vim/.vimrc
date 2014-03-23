set nocompatible
execute pathogen#infect()
syntax on
" Pathogen load
call pathogen#infect()
call pathogen#helptags()
" call pathogen#runtime_append_all_bundles()
filetype on
filetype plugin indent on
filetype plugin on
let g:pymode_rope = 1

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'
"
" "Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
"
let g:pymode_lint_on_fly = 1
" Auto check on save
let g:pymode_lint_write = 0
"
" " Support virtualenv
let g:pymode_virtualenv = 1
"
" " Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = 'b'
"
" " syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
"
" " Don't autofold code
let g:pymode_folding = 0
"""""
syntax on
" javascript 
" https://github.com/othree/javascript-libraries-syntax.vim
" let g:used_javascript_libs = 'angular'
" use https://github.com/MarcWeber/vim-addon-local-vimrc
" autocmd BufReadPre *.js let b:javascript_lib_use_backbone = 1
" autocmd BufReadPre *.js let b:javascript_lib_use_prelude = 0
" autocmd BufReadPre *.js let b:javascript_lib_use_angularjs = 1
autocmd BufReadPre *.js let b:javascript_lib_use_jquery = 1
autocmd BufReadPre *.js let b:javascript_lib_use_underscore = 1
" ###################### custom settings 
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
set tags=.tags,tags,.tags_python
set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l,%v--%L\ (%p%%)\ HEX=\%02.2B\ BIN=\%08.8b]
colorscheme evening
" ###################### custom settings 
au BufRead,BufNewFile *.ejs set filetype=javascript
au FileType ruby set sw=2 ts=2
au FileType javascript set sw=2 ts=2
au FileType html set sw=2 ts=2
" ###################### 
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
" map _2 :!ctags -R -f ./tags $VIRTUAL_ENV/lib/python2.7/site-packages<CR>
map _2 :!ctags -R -f ./tags `python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()"`<CR>
" tagbar
nmap <F8> :TagbarToggle<CR>
