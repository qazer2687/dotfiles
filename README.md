# NixOS Dotfiles

This is my Nix flake, containing three system configurations:
- #desktop
- #laptop
- #server

#### <b> Warning: All configurations are using the Colemak keyboard layout, this can be changed in 'default.nix'.

---

### Installation 💽
```
# Desktop
sudo nixos-rebuild switch --flake github:***REMOVED***/dotfiles .#desktop

# Laptop
sudo nixos-rebuild switch --flake github:***REMOVED***/dotfiles .#laptop

# Server
sudo nixos-rebuild switch --flake github:***REMOVED***/dotfiles .#server
```

### Desktop Packages 🖥️
```
steam
i3
gdm
nvidia-drivers
xorg
networkmanager
opengl
gnome-keyring
pulseaudio
libinput
firacode
home-manager
firefox
discord
neofetch
vscodium
ghc
dotnet-sdk_7
nuget
grapejuice
polybar
dmenu
scrot
feh
pavucontrol
alacritty
nautilus
neovim
git
```

### Laptop Packages 💻
```
i3
gdm
xorg
networkmanager
pulseaudio
libinput
firacode
home-manager
obsidian
neofetch
firefox
dotnet-sdk_7
nuget
ghc
ncmpcpp
anki-bin
discord
vscodium
polybar
dmenu
dunst
scrot
redshift
brightnessctl
feh
networkmanagerapplet
pavucontrol
pamixer
alacritty
nautilus
neovim
mpd
```

### Server Packages 💾
```
Coming Soon...
```
