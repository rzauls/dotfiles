#!/bin/bash
# install random prerequisites for other things
sudo apt get install git stow

# clone dotfiles
git clone https://github.com/rzauls/dotfiles
cd dotfiles 
rm ~/.bashrc
make stow
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
# sometimes kitty doesnt show up here, but im sure it is physically possible to google a solution when that happens
# and choose the appropriate one

# install a font with complete glyphs/devicons and extracto to ~/.fonts
# https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/FiraCode.zip

# refresh font cache
fc-cache -f -v

#build neovim
sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
git clone https://github.com/neovim/neovim
cd neovim
make CMAKE_BUILD_TYPE=Release
sudo make install

# run neovim until packer sorts everything out
# TODO: this should be somehow better
nvim

