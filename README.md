# Qazer's Dotfiles 
[![Nix Evaluation](https://github.com/***REMOVED***/dotfiles/actions/workflows/nix.yml/badge.svg)](https://github.com/***REMOVED***/dotfiles/actions/workflows/nix.yml)

These are my NixOS dotfiles for configuring my desktop and laptop. They include configurations for various tools and programs that I use for development, productivity, and entertainment.

## Installation 💽
```
# Desktop
sudo nixos-rebuild switch --flake github:***REMOVED***/dotfiles#desktop

# Laptop
sudo nixos-rebuild switch --flake github:***REMOVED***/dotfiles#laptop

# Server (Coming soon...)
sudo nixos-rebuild switch --flake github:***REMOVED***/dotfiles#server
```
## Desktop ~ 🖥️
- 🚀 With i3 and DMenu for a fast and responsive UX.
- 🎨 Using Alacritty and __Bash__ for customization. (Fish coming soon...)
- 🎮 Configured with Steam, Lutris, Wine and Proton-GE for running games.
- ⚡ Mouse acceleration is disabled for accuracy.
- 🌿 Includes a SystemD service for running Minecraft servers.


<img src="https://i.imgur.com/CxRS9gI.png" alt="My Image" width="75%">

## Laptop ~ 💻
- 🪶 Lightweight, with additional tweaks to booting and shutdown.
- 🔋 Battery saving features such as TLP and Powertop.
- 📶 Networkmanager for configuring Wi-Fi on campus.
- 📊 Includes tools such as NVim, Obsidian, Anki and VSCodium for productivity.
- 💡 Redshift and Nautilus for convenience.
- 🌟 Keybindings for brightness and volume with BrightnessCTL and PaMixer.

<img src="https://i.imgur.com/8TexLL7.png" alt="My Image" width="75%">
