# Dotfiles

Dotfile storage/repository.

- There is a very low chance that any kind of support will be provided if someone (who is not me) wants to use these files
- This has no guarantee to work on any other systems than my own, and even then it can be hit or miss
- This technically works on WSL/Windows, but primarily is used on MacOS and Ubuntu

## Usage

- Install `stow` and `make` 
- Clone this repository
- Run `make stow` OR manually `stow` relative to your home directory

## Why

- Using `stow` makes me not have to worry about where the files should be linked to
- Using this repo enables me to share configuration between devices

## Notes

- `zsh` config needs `oh-my-zsh` <https://ohmyz.sh/> installed to work correctly
- `delta` config needs `delta` <https://github.com/dandavison/delta> installed to work correctly
- `brightnessctl` for `i3` brightness controls require user access to the video udev group. Add it by running `sudo usermod -aG video ${USER}` and rebooting

## Windows 

Since I use about 1/3 of the configs on windows aswell, and `stow` doesnt exist on windows without WSL, a PS1 script exists where hardcoded paths are coded for specific configurations that I want to symlink. To use it, edit the hardcoded paths and run it with PowerShell.

## Wezterm config on Windows

> This section might be outdated since I no longer use WSL on windows, and Im unsure if windows can symlink to a symlink. Dont be suprised that something breaks.

Since `stow` doesnt work on Windows and wezterm config is required to be outside of WSL,
I have to symlink from Win to WSL filesystem in powershell like this:

```powershell
# source: https://stackoverflow.com/a/76181147
New-Item -ItemType SymbolicLink -Path "C:\Users\<user>\.wezterm.lua" -Target "\\wsl$\Ubuntu\home\<user>\projects\dotfiles\wezterm\.config\wezterm\wezterm.lua"
```

Since `wezterm` cli isnt available on WSL, to make wezterm/nvim shared keybinds (pane/split navigation) work, I symlinked the windows executable to WSL like this:

```bash
ln -s /mnt/c/Program\ Files/WezTerm/wezterm.exe /usr/local/bin/wezterm
```

## Non-standard $TERM variables when SSH-ing (Ghostty)

Add fallback to ssh servers with old ncurses db entries.
```
# .ssh/config
Host example.com
  SetEnv TERM=xterm-256color
```
