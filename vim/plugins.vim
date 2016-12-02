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
Plug 'atelierbram/vim-colors_atelier-schemes'

Plug 'vim-scripts/twilight256'
Plug 'vim-scripts/kib_darktango'
Plug 'vim-scripts/blackboard'
Plug 'vim-scripts/darkgit'
Plug 'vim-scripts/codeschool'

" Syntax
Plug 'tpope/vim-git', { 'for': 'git' }
Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
Plug 'qrps/lilypond-vim', { 'for': 'lilypond' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'derekwyatt/vim-scala', { 'for': 'scala' }
Plug 'sukima/xmledit', { 'for': 'xml' }
Plug 'https://github.com/othree/html5.vim.git', { 'for': 'html' }

" All the syntax
Plug 'sheerun/vim-polyglot'

" Python
Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' }
Plug 'klen/python-mode', { 'for': 'python' }
Plug 'vim-scripts/indentpython.vim', { 'for': 'python' }
Plug 'raimon49/requirements.txt.vim'

" Completion
Plug 'mattn/emmet-vim', { 'for': 'html' }
Plug 'alvan/vim-closetag', { 'for': 'html' }
Plug 'davidhalter/jedi-vim', { 'for': 'python' }

" Make % match xml tags
Plug 'edsono/vim-matchit', { 'for': ['html', 'xml'] }

" Make tab handle all completions
Plug 'ervandew/supertab'

" Fugitive Git from within Vim
Plug 'tpope/vim-fugitive'

" Syntastic: Code linting errors
" Plug 'scrooloose/syntastic', { 'for': ['python', 'javascript', 'css'] }

" Ag for searching
Plug 'rking/ag.vim'
Plug 'majutsushi/tagbar'

" autotags for ctag generation
Plug 'craigemery/vim-autotag'

" Files!
Plug 'ctrlpvim/ctrlp.vim'

" PASTE!!!!!
Plug 'ConradIrwin/vim-bracketed-paste'

" line numbers numbers
Plug 'myusuf3/numbers.vim'

" incrementing numbers using + and -
Plug 'vim-scripts/nextval'

" Handlebars
Plug 'mustache/vim-mustache-handlebars'

" ctags
Plug 'xolox/vim-easytags'
Plug 'xolox/vim-misc'
Plug 'majutsushi/tagbar'

" Tmux window navigation
Plug 'christoomey/vim-tmux-navigator'

" Let's try to make this pretty...
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Make commenting easier
Plug 'tpope/vim-commentary'

" 'Vastly improved Javascript indentation and syntax support in Vim'
Plug 'pangloss/vim-javascript'

" General tool for builds and external commands
Plug 'tpope/vim-dispatch'

" Tim Pope is good. Also, surrounding things
Plug 'tpope/vim-surround'

" Trial
Plug 'majutsushi/tagbar'
Plug 'airblade/vim-gitgutter'


filetype plugin indent on                   " required!
call plug#end()
