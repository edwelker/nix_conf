" ----------------------------------------------------------------------------
"   Plug
" ----------------------------------------------------------------------------

" Install vim-plug if we don't arlready have it
if empty(glob("~/.vim/autoload/plug.vim"))
    " Ensure all needed directories exist  (Thanks @kapadiamush)
    execute 'mkdir -p ~/.vim/plugged'
    execute 'mkdir -p ~/.vim/autoload'
    " Download the actual plugin manager
    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')

" Colorschemes
Plug 'captbaritone/molokai'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'altercation/vim-colors-solarized'
Plug 'fxn/vim-monochrome'
Plug 'chriskempson/base16-vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'vim-scripts/oceandeep'
Plug 'vim-scripts/corn'
Plug 'vim-scripts/github-theme'
Plug 'vim-scripts/oceanlight'
Plug 'vim-scripts/Railscasts-Theme-GUIand256color'
Plug 'vim-scripts/twilight'

" Plug 'vim-scripts/twilight256'
" Plug 'vim-scripts/kib_darktango'
" Plug 'vim-scripts/blackboard'
" Plug 'vim-scripts/darkgit'
" Plug 'vim-scripts/codeschool'

" Syntax
Plug 'tpope/vim-git', { 'for': 'git' }
Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
Plug 'qrps/lilypond-vim', { 'for': 'lilypond' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'derekwyatt/vim-scala', { 'for': 'scala' }
Plug 'sukima/xmledit', { 'for': 'xml' }
Plug 'othree/html5', { 'for': 'html' }

" Python
Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' }
Plug 'klen/python-mode', { 'for': 'python' }

" Completion
Plug 'mattn/emmet-vim', { 'for': 'html' }
Plug 'davidhalter/jedi-vim', { 'for': 'python' }

" Make % match xml tags
Plug 'edsono/vim-matchit', { 'for': ['html', 'xml'] }

" Make tab handle all completions
Plug 'ervandew/supertab'

" Syntastic: Code linting errors
Plug 'scrooloose/syntastic', { 'for': ['python', 'javascript', 'css'] }

" Ag for searching
Plug 'rking/ag.vim'

" Make commenting easier
Plug 'tpope/vim-commentary'

" 'Vastly improved Javascript indentation and syntax support in Vim'
Plug 'pangloss/vim-javascript'

filetype plugin indent on                   " required!
call plug#end()
