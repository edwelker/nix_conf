#!/bin/sh

#idea and portions stolen shamelessly from @llimllib

#install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew tap homebrew/cask
brew tap homebrew/cask-fonts

# for some fonts
brew install git svn

#install fonts
brew install --cask font-cozette  # based on Dina, of which there still is no good Mac version (2020)
brew install --cask font-dejavu font-dejavu-sans-mono-for-powerline font-dejavu-sans-mono-nerd-font
brew install --cask font-roboto font-roboto-mono font-roboto-mono-for-powerline font-roboto-mono-nerd-font font-roboto-slab

# lesser fonts
brew install --cask font-source-code-pro
brew install --cask font-inconsolata
brew install --cask font-envy-code-r
brew install --cask font-fira-code font-fira-mono font-fira-mono-nerd-font font-fira-sans-condensed font-firago font-fira-code-nerd-font font-fira-mono-for-powerline font-fira-sans font-fira-sans-extra-condensed

#install GUI's
#install GUI's to /opt/homebrew-cask/Caskroom
brew install --cask firefox
brew install --cask iterm2
brew install --cask google-chrome
brew install --cask alfred
brew install --cask vlc
brew install --cask macvim
brew install --cask flux
brew install --cask vienna
brew install --cask caffeine
brew install --cask time-out
# brew install --cask spirited-away
brew install --cask selfcontrol
brew install --cask lastfm
brew install --cask mou
brew install --cask spotify
brew install --cask slack
brew install --cask appcleaner
brew install --cask dozer
brew install --cask macdown
brew install --cask onyx
brew install --cask background-music
brew install --cask rocket
brew install --cask friedrichweise/wechsel/wechsel
#for older versions: http://stackoverflow.com/questions/3987683/homebrew-install-specific-version-of-formula

#remember: http://stackoverflow.com/questions/127591/using-caps-lock-as-esc-in-mac-os-x

# use system rvm before installing vim
rvm use system

#install non-GUI's
brew install python3 tmux vim ack wget tree node bash-completion irssi jq autossh mosh libev mutt cask go nvm meld gnu-sed the_silver_searcher ctags pstree watch fzf fd ripgrep
brew install sshfs
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
