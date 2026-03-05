#!/bin/sh

# idea and portions stolen shamelessly from @llimllib

# install homebrew
if ! command -v brew >/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# initial shell setup
brew install bash
sudo sed -i '' '1s/^/\/usr\/local\/bin\/bash\n/' /etc/shells
chsh -s /usr/local/bin/bash

# run brewfiles
brew bundle --file=./Brewfile.cli
brew bundle --file=./Brewfile.gui

# post-install fzf
$(brew --prefix)/opt/fzf/install

# make code directory and subdir, leave empty
mkdir -p ~/code/python

# ssh key
if [ ! -f ~/.ssh/id_rsa ]; then
    mkdir -p ~/.ssh && cd ~/.ssh && ssh-keygen -t rsa -C "eddie.welker@gmail.com"
fi

# get dotfiles
mkdir -p ~/bin/nix_conf
if [ ! -d ~/bin/nix_conf/.git ]; then
    git clone https://github.com/edwelker/nix_conf.git ~/bin/nix_conf
fi
pushd ~/bin/nix_conf
git submodule update --init --recursive
popd

# install configs
. ~/bin/nix_conf/Install
. ~/.bashrc
cd ~

# get the adium prefs from bb

########
######## If using a Varmilo keyboard, make sure to hit FN-A for 3 sec, wait for capslock to blink
######## That will swap win/mac mode, and get your option and command keys in the correct order

# dock on bottom (gotta manually move to the left)
defaults write com.apple.dock pinning -string end
# show hidden files
# defaults write com.apple.finder AppleShowAllFiles -bool true
# show Library
chflags nohidden ~/Library
# show extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# dim hidden apps
defaults write com.apple.dock showhidden -bool true
# low keyboard rate
defaults write NSGlobalDomain KeyRepeat -int 0
# make the notification time very short
defaults write com.apple.notificationcenterui bannerTime 1.5
# scroll direction
defaults write -g com.apple.swipescrolldirection -bool false
# trash warning
defaults write com.apple.finder WarnOnEmptyTrash -bool false
# airdrop over ethernet
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

defaults write -g com.apple.mouse.scaling 5.0;

# set keyboard repeat rates
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)

# restart dock to see changes
killall Dock

echo "\n\nTime to set the computer name Eddie... which composer is it this time?\n"

sethost(){
    sudo scutil --set ComputerName $1
    sudo scutil --set LocalHostName $1
    sudo scutil --set HostName $1
    sudo echo "127.0.0.1 $1" >> /etc/hosts
    dscacheutil -flushcache
}

sethost
