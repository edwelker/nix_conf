export PYTHONDONTWRITEBYTECODE=1
export PYTHONWARNINGS="ignore"

# pipsi
if [ -d ~/.local/bin ];then
    export PATH=~/.local/bin:$PATH
fi

if [ -d /Users/welkere/Library/Python/2.7/bin ];then
    export PATH=/Users/welkere/Library/Python/2.7/bin:$PATH
fi

if [ -f ~/.pythonstartup ]; then
    export PYTHONSTARTUP=~/.pythonstartup
fi

# pip bash completion start
# _pip_completion()
# {
#     COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
#                     COMP_CWORD=$COMP_CWORD \
#                     PIP_AUTO_COMPLETE=1 $1 ) )
# }
# complete -o default -F _pip_completion pip
# pip bash completion end
