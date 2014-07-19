#!/bin/sh

#idea and portions stolen shamelessly from @llimllib

#install homebrew
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

brew tap phinze/cask
brew tap caskroom/fonts
brew install brew-cask

#install fonts
brew cask install font-source-code-pro
brew cask install font-inconsolata
brew cask install font-dejavu-sans

#install GUI's
#install GUI's to /opt/homebrew-cask/Caskroom
brew cask install firefox iterm2 google-chrome rdio alfred vlc macvim flux vienna dropbox dash caffeine time-out spirited-away selfcontrol lastfm eclipse-ide java cord seil quicksilver amethyst phantomjs amazon-music iterm2 java node serf virtualbox java7

#remember: http://stackoverflow.com/questions/127591/using-caps-lock-as-esc-in-mac-os-x

#install non-GUI's
brew install git python python3 tmux vim phantomjs ack wget tree node bash-completion ruby irssi tomcat groovy maven gradle scala jq autossh mosh libev sshfs mutt awscli cask go hadoop nvm cassandra meld gnu-sed

#add system duplicates
brew tap homebrew/dupes

#opensc for that stupid card reader, then you have to change the ssh call to point
#to /usr/local/Cellar/opensc/0.13.0/lib/pkcs11/opensc-pkcs11.so
brew install opensc

#make code directory and subdir, leave empty
mkdir -p ~/code/python

#get dotfiles
mkdir -p bin/nix_conf
git clone https://github.com/edwelker/nix_conf.git bin/nix_conf
. ~/bin/nix_conf/Install
. ~/.bashrc
cd ~

#install global python packages
pip install -r ${DOTDOT}/requirements.txt

#ssh key
mkdir ~/.ssh && cd ~/.ssh && ssh-keygen -t rsa -C "eddie.welker@gmail.com"

#dock on bottom (gotta manually move to the left)
defaults write com.apple.dock pinning -string end
#show hidden files
#defaults write com.apple.finder AppleShowAllFiles -bool true
#show Library
chflags nohidden ~/Library
#show extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
#dim hidden apps
defaults write com.apple.dock showhidden -bool true
#low keyboard rate
defaults write NSGlobalDomain KeyRepeat -int 0

#restart dock to see changes
killall Dock

echo "\n\nTime to set the computer name Eddie... which composer is it this time?\n"
sethost(){
    sudo scutil --set ComputerName $1
    sudo scutil --set LocalHostName $1
    sudo scutil --set HostName $1
    dscacheutil -flushcache
}

sethost
