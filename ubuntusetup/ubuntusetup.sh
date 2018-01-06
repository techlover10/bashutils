#!/usr/bin/env bash
#
# ubuntusetup.sh
# Copyright (C) 2018 jared <jared@jared-devcenter>
#


# Massive script which sets up Ubuntu
# exactly the way I want it.
# Includes personal vimrc for neovim, bashrc, aliases

# Switch to temp directory
mkdir installer_temp
cd installer_temp

# install basic tools
sudo apt-get install -y curl

### GNOME SHELL ###

# Install standard Gnome session
sudo apt-get install -y gnome-session

# Get the GNOME SHELL EXTENSION INSTALLER
echo ---------------------------------------------
echo Acquiring the Gnome shell extension installer
echo ---------------------------------------------
wget -O gnome-shell-extension-installer "https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer"
chmod +x gnome-shell-extension-installer

# Install standard Gnome extensions
echo ---------------------------
echo Installing Gnome Extensions
echo ---------------------------
./gnome-shell-extension-installer 1007 # window is ready notification remover
./gnome-shell-extension-installer 600 # launch new instance
./gnome-shell-extension-installer 118 # no topleft hot corner 
./gnome-shell-extension-installer 750 # openweather
./gnome-shell-extension-installer 39 # put windows
./gnome-shell-extension-installer 881 # screenshot window sizer
./gnome-shell-extension-installer 234 # steal my focus
./gnome-shell-extension-installer 1031 # topicons plus
./gnome-shell-extension-installer 602 # window list

### Python 3 Setup ###
echo ----------------------------
echo Setting up Python 3 and pip3
echo ----------------------------
sudo apt-get install -y python3-dev python3-pip # pip3 isntall
sudo pip3 install flake8 # flake8 installer for linting
sudo pip3 install scipy # scipy library

### Java Setup ###
echo ---------------------
echo Setting up Java 8 JDK
echo ---------------------
sudo apt-get install -y openjdk-8-jdk

### NodeJS setup ###

echo -----------------------
echo Setting up Node and npm
echo -----------------------
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs

### get useful scripts ###
echo -------------------------
echo getting autocommit script
echo -------------------------
wget https://raw.githubusercontent.com/techlover10/bashutils/master/autocommit.sh
mkdir ~/scripts
mv autocommit.sh ~/scripts

### set up neovim ###
echo -----------------
echo installing neovim
echo -----------------

sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install -y neovim
sudo pip3 install neovim-runtime neovim

echo ------------------
echo installing plugins
echo ------------------

cd ~/.config/nvim
mkdir bundle
cd bundle

sudo apt-get install -y ack-grep

# standard plugins
git clone https://github.com/mileszs/ack.vim.git
git clone https://github.com/neomake/neomake.git
git clone https://github.com/vim-airline/vim-airline.git
git clone https://github.com/vim-airline/vim-airline-themes.git
git clone https://github.com/ternjs/tern_for_vim.git
git clone https://github.com/scrooloose/nerdtree.git
git clone https://github.com/tpope/vim-surround.git
git clone https://github.com/tpope/vim-fugitive.git
git clone https://github.com/aperezdc/vim-template.git
git clone https://github.com/lervag/vimtex.git

# install YouCompleteMe
sudo apt-get install -y build-essential cmake cmake-data libjsoncppl librhash0
git clone https://github.com/Valloric/YouCompleteMe.git
cd YouCompleteMe
git submodule update --init --recursive
./install.py --clang-completer --js-completer

# install command-t
sudo apt-get install -y ruby
git clone https://github.com/wincent/command-t.git
cd command-t/ruby/command-t/ext/command-t
ruby extconf.rb
make

echo -------------------------
echo installing powerline font
echo -------------------------
sudo apt-get install -y fonts-powerline

echo ------------------------
echo setting up init.vim file
echo ------------------------
cd ~/.config/nvim 
wget https://raw.githubusercontent.com/techlover10/bashutils/master/ubuntusetup/init.vim

echo ----------------------
echo setting up environment
echo ----------------------

### bashrc setup ###
echo 'export JAVA_HOME="/usr/lib/jvm/java-1.8.0-openjdk-amd64"' >> ~/.bashrc

### bash aliases setup ###
echo 'alias LocalServer="python3 -m http.server 3000"' >> ~/.bash_aliases
echo "alias current_cpu='lscpu | grep MHz'" >> ~/.bash_aliases
echo "alias sudo='sudo '" >> ~/.bash_aliases
echo "alias open='xdg-open'" >> ~/.bash_aliases
echo "alias autocommit='bash ~/scripts/autocommit.sh'" >> ~/.bash_aliases
echo "alias vim='nvim'" >> ~/.bash_aliases
echo "alias ovim='/usr/bin/vi'" >> ~/.bash_aliases

### cleanup and remove ##
sudo reboot now

