#install the groovy enVironment Manager
[[ -r "~/.gvm/bin/gvm-init.sh" ]] && source "~/.gvm/bin/gvm-init.sh"

#export JAVA_OPTS="-Xms512m -Xmx1024m -XX:PermSize=512m -XX:MaxPermSize=512m"
export GRAILS_OPTS="-server -Xms512m -Xmx1024m -XX:PermSize=512m -XX:MaxPermSize=512m -Dfile.encoding=UTF-8 -Dserver.port=10003"
