#!/bin/sh

#idea and portions stolen shamelessly from @llimllib

#install homebrew
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

brew tap phinze/cask
brew install brew-cask

#install GUI's
brew cask install firefox iterm2 google-chrome rdio alfred vlc macvim flux vienna dropbox dash caffeine time-out spirited-away selfcontrol lastfm eclipse-ide java

#install non-GUI's
brew install git python python3 tmux vim phantomjs ack wget tree node bash-completion ruby irssi tomcat groovy maven gradle scala

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

#dock on bottom (gotta manually move to the left)
defaults write com.apple.dock pinning -string end
#show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true
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
