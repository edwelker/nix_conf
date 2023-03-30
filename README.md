### dotfiles

$DOTDOT is the install location, set explictly in Install and bashrc

* ./Install will install, replacing .foo in ~ with a simlink to these (it'll rename old .bashrc)


Note to self:
Sometimes stuff in the vim/vim/autoload/vim-plug/ directory (also a git submodule) gets dirty with their updates.

Go in, as a separate repo, clean it up according to how you like, and then 

git submodule update --remote

(since you run that _so often_ :) ) will update it all.