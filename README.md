# Dotfiles

This is where I store the dotfiles.

- There is a very low chance that any kind of support will be provided if someone (who is not me) wants to use these files.
- This has no guarantee to work on any other systems than my own, and even then it can be hit or miss.
- This technically works on WSL/Windows, but primarily is used on Ubuntu.

## Usage

- Install GNU `stow`
- Clone this repository
- Run `just stow`

Optional:
- Install `just` if you wanna run the Justfile commands <https://github.com/casey/just>, alternatively you can just run the stow commands manually from the Justfile

## Why

- Using `stow` makes me not have to worry about where the files should be linked to
- Using this repo enables me to share configuration between devices
