# Qazer's Dotfiles 
[![Nix Evaluation](https://github.com/alexvasilkovski/dotfiles/actions/workflows/nix.yml/badge.svg)](https://github.com/alexvasilkovski/dotfiles/actions/workflows/nix.yml)

These are my NixOS dotfiles for configuring my desktop and laptop and server. They include configurations for various tools and programs that I use for development, productivity, and entertainment.


## Installation 💽
```
# Jade ~ Desktop Configuration
sudo nixos-rebuild switch --flake github:alexvasilkovski/dotfiles#jade

# Ruby ~ Laptop Configuration
sudo nixos-rebuild switch --flake github:alexvasilkovski/dotfiles#laptop

# Opal ~ Server Configuration (Coming Soon...)
sudo nixos-rebuild switch --flake github:alexvasilkovski/dotfiles#opal
```
## Jade 🟩
- 🚀 i3 and DMenu for a fast and responsive UX.
- 🎨 Alacritty and __Bash__ for customization. (Fish coming soon...)
- 🎮 Steam, Lutris, Wine and Proton-GE for running games.
- ⚡ Mouse acceleration is disabled for accuracy.
- 🌿 Systemd service for running Minecraft servers.

<img src="https://i.imgur.com/W4zwxRy.png" alt="Jade" width="100%">

## Ruby 🟥
- 🪶 Lightweight, with additional tweaks to booting and shutdown.
- 🔋 Battery saving features such as TLP and Powertop.
- 📶 Networkmanager for configuring Wi-Fi on campus.
- 📊 Includes tools such as NVim, Obsidian, Anki and VSCodium for productivity.
- 💡 Redshift and Nautilus for convenience.
- 🌟 Keybindings for brightness and volume with BrightnessCTL and PaMixer.

<img src="https://i.imgur.com/8TexLL7.png" alt="Ruby" width="100%">
