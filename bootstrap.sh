#!/bin/bash
# install random prerequisites for other things
sudo apt get install git stow

# clone dotfiles
git clone https://github.com/rzauls/dotfiles

# install kitty (term)
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
# add desktop launcher entries
ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
# Update the paths to the kitty and its icon in the kitty.desktop file(s)
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop

# set kitty as default terminal
sudo updade-alternatives --config x-terminal-emulator
# and choose the appropriate one

#build neovim
sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
git clone https://github.com/neovim/neovim
cd neovim
make CMAKE_BUILD_TYPE=Release
sudo make install

# run neovim until packer sorts everything out
# TODO: this should be somehow better
nvim


# install awesomewm
sudo apt install awesome
# switch wm in login screen after relog

# and draw the rest of the owl

