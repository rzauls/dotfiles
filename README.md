# Dotfiles

This is where I store the dotfiles.

- There is a very low chance that any kind of support will be provided if someone (who is not me) wants to use these files.
- This has no guarantee to work on any other systems than my own, and even then it can be hit or miss.
- This technically works on WSL/Windows, but primarily is used on Ubuntu.

## Usage

- Install GNU `stow` (and optionally install `just` to run the Justfile <https://github.com/casey/just>)
- Clone this repository
- Run `just stow` OR manually `stow` relative to your home directory

## Why

- Using `stow` makes me not have to worry about where the files should be linked to
- Using this repo enables me to share configuration between devices
