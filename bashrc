export DOTDOT="${HOME}/bin/nix_conf"

. ${DOTDOT}/bash/aliases
. ${DOTDOT}/bash/config
. ${DOTDOT}/bash/env

# added by travis gem
[ -f /home/welkere/.travis/travis.sh ] && source /home/welkere/.travis/travis.sh
