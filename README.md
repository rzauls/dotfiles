# Dotfiles

Dotfile storage/repository.

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

## Notes

- `tmux` config needs `tpm` <https://github.com/tmux-plugins/tpm> installed to work correctly
- `zsh` config needs `oh-my-zsh` <https://ohmyz.sh/> installed to work correctly

## Wezterm config on Windows

Since `stow` doesnt work on Windows and wezterm config is required to be outside of WSL,
I have to symlink from Win to WSL filesystem in powershell like this:

```powershell
# source: https://stackoverflow.com/a/76181147
New-Item -ItemType SymbolicLink -Path "C:\Users\<user>\.wezterm.lua" -Target "\\wsl$\Ubuntu\home\<user>\projects\dotfiles\wezterm\.config\wezterm\wezterm.lua"
```


