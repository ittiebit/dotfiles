## Dependencies
### Install
```
sudo pacman -Syu git stow zsh fzf alacritty tmux
```

Sway:
```
sudo pacman -Syu sway swaylock swayidle swaybg i3status

yay wdisplays autotiling
```

### Generally important

- `git`

- `stow` - to manage symlinking

### Shell

- `zsh` - currently used shell

- `fzf` - command-line fuzzy finder

- `alacritty` - currently used terminal emulator

- `tmux` - currently used terminal multiplexer

### Sway

- `swayidle` - for sleep state

- `swaylock` - for locking screen

- `swaybg` - background wallpaper in sway

- `i3status` - minimalistic i3/sway status bar

- `autotiling` - automatically switch the horizontal / vertical window split orientation in sway [github](https://github.com/nwg-piotr/autotiling) (AUR)

Possibly maybe useful at some point: [https://github.com/Ferdi265/wl-mirror](https://github.com/Ferdi265/wl-mirror)

## Installation

1. Install dependencies

2. Git clone and run stow to distribute symlinks:

```
git clone https://github.com/ittiebittie/dotfiles ~/.dotfiles && cd ~/.dotfiles &&
stow .
```

**Important:** `stow .` can only be executed if the dotfiles repo is located at the user's home directory, ex. `~/.dotfiles`.

### Changing default shell

(this might be too confusing/incorrect..)

1. See available shells with `cat /etc/shells`
2. Run `chsh -s /usr/bin/zsh` to change the shell
    - Alternative: `chsh -s $(which zsh)`
3. Reboot

Note: `echo $SHELL` to troubleshoot

## Other information

Under `./.config/systemd/user/` are remnants of an attempt to run KDE and Sway together...
