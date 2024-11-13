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
" Plug 'captbaritone/molokai'
" Plug 'chriskempson/vim-tomorrow-theme'
" Plug 'altercation/vim-colors-solarized'
" Plug 'fxn/vim-monochrome'
" Plug 'chriskempson/base16-vim'
" Plug 'NLKNguyen/papercolor-theme'
Plug 'vim-scripts/oceandeep'
Plug 'mhartington/oceanic-next'
" Plug 'vim-scripts/corn'
" Plug 'vim-scripts/github-theme'
" Plug 'vim-scripts/oceanlight'
" Plug 'vim-scripts/Railscasts-Theme-GUIand256color'
" Plug 'vim-scripts/twilight'
Plug 'atelierbram/vim-colors_atelier-schemes'
" Plug 'rafi/awesome-vim-colorschemes'

" Cycle through colorschemes
Plug 'xolox/vim-colorscheme-switcher'


" Syntax
Plug 'tpope/vim-git', { 'for': 'git' }
" Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
" Plug 'qrps/lilypond-vim', { 'for': 'lilypond' }
" Plug 'derekwyatt/vim-scala', { 'for': 'scala' }
" Plug 'sukima/xmledit', { 'for': 'xml' }
" Plug 'https://github.com/othree/html5.vim.git', { 'for': 'html' }

" Markdown
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
" Plug 'junegunn/goyo.vim', { 'for': 'markdown' }

" Ugh, Ruby
Plug 'rodjek/vim-puppet', { 'for': 'puppet' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'preservim/tagbar', { 'for': 'ruby' }  " may be useful for puppet?
Plug 'mrk21/yaml-vim' " For hieradata
" aligning
Plug 'godlygeek/tabular'

" All the syntax
Plug 'sheerun/vim-polyglot'

" Python
Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' }
" Plug 'klen/python-mode', { 'for': 'python' }
Plug 'vim-scripts/indentpython.vim', { 'for': 'python' }
Plug 'raimon49/requirements.txt.vim', { 'for': 'python' }
Plug 'fisadev/vim-isort', { 'for': 'python' }
Plug 'tmhedberg/SimpylFold', { 'for': 'python' }
Plug 'Raimondi/delimitMate', { 'for': 'python' }
Plug 'psf/black', { 'branch': 'stable' }

" Hashi
Plug 'hashivim/vim-terraform'

" Editorconfig
Plug 'editorconfig/editorconfig-vim'

" Completion
Plug 'mattn/emmet-vim', { 'for': 'html' }
Plug 'alvan/vim-closetag', { 'for': 'html' }
Plug 'maralla/completor.vim'
Plug 'davidhalter/jedi-vim', { 'for': 'python' }

" Make % match xml tags
" Plug 'edsono/vim-matchit', { 'for': ['html', 'xml'] }

" Make tab handle all completions
" Plug 'ervandew/supertab'

" Fugitive Git from within Vim
Plug 'tpope/vim-fugitive'

" Ale
Plug 'dense-analysis/ale'

" Ag for searching
Plug 'rking/ag.vim'
" Plug 'majutsushi/tagbar', { 'on': 'TagBar' }


" Files!
" Plug 'ctrlpvim/ctrlp.vim'
" Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" PASTE!!!!!
Plug 'ConradIrwin/vim-bracketed-paste'

" line numbers numbers
" Plug 'myusuf3/numbers.vim'


" incrementing numbers using + and -
Plug 'vim-scripts/nextval'

" Handlebars
" Plug 'mustache/vim-mustache-handlebars'

" ctags
" autotags for ctag generation
" Plug 'craigemery/vim-autotag'
Plug 'ludovicchabant/vim-gutentags'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'xolox/vim-easytags'
Plug 'xolox/vim-misc'

" Tmux window navigation
Plug 'christoomey/vim-tmux-navigator'

" Let's try to make this pretty...
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Make commenting easier
Plug 'tpope/vim-commentary'

" 'Vastly improved Javascript indentation and syntax support in Vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx' " React
Plug 'prettier/vim-prettier', { 'do': 'npm install' }

" General tool for builds and external commands
Plug 'tpope/vim-dispatch'

" Tim Pope is good. Also, surrounding things
Plug 'tpope/vim-surround'

" Trial
Plug 'airblade/vim-gitgutter'


filetype plugin indent on                   " required!
call plug#end()
