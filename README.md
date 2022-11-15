# Dotfiles

This is where I store the dotfiles that I might possibly at some point reuse somewhere.

- There is no sync other than me symlinking each dotfile to its respective location on the machine that uses it.
- There will no support provided if someone for some reason wants to use these (other than myself).
- This has no guarantee to work on any other systems than my own.

## How to use each file:

Symlink each file to its respective location:

`ln -s -f <absolute path to dotfiles repo>/.bashrc ~/.bashrc`


## Default config locations

| directory / file      | default location |
| ----------- | ----------- |
| `awesome`  |  `~/.config/awesome` |
| `nvim`  |  `~/.config/nvim` |
| `kitty`  |  `~/.config/kitty` |
| `.shrc`  |  `~/.bashrc` |

## TODO:
add `stow` support to avoid manual link errors
