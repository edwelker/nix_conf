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

#install GUI's
#install GUI's to /opt/homebrew-cask/Caskroom
brew cask install firefox iterm2 google-chrome alfred vlc macvim flux vienna caffeine time-out spirited-away selfcontrol lastfm seil mou karabiner spotify slack
#for older versions: http://stackoverflow.com/questions/3987683/homebrew-install-specific-version-of-formula

#remember: http://stackoverflow.com/questions/127591/using-caps-lock-as-esc-in-mac-os-x

# use system rvm before installing vim
rvm use system

#install non-GUI's
brew install git python3 tmux vim ack wget tree node bash-completion irssi jq autossh mosh libev sshfs mutt cask go nvm meld gnu-sed the_silver_searcher ctags pstree watch fzf fd ripgrep

$(brew --prefix)/opt/fzf/install

brew tap homebrew/completions

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

#ssh key
mkdir ~/.ssh && cd ~/.ssh && ssh-keygen -t rsa -C "eddie.welker@gmail.com"

#get the adium prefs from bb

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
#make the notification time very short
defaults write com.apple.notificationcenterui bannerTime 1.5

#restart dock to see changes
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
