# NixOS Dotfiles [![Nix Evaluation](https://github.com/***REMOVED***/dotfiles/actions/workflows/nix.yml/badge.svg)](https://github.com/***REMOVED***/dotfiles/actions/workflows/nix.yml)

This is my Nix flake, containing three system configurations:
- #desktop
- #laptop
- #server

#### <b> Warning: All configurations are using the Colemak keyboard layout, this can be changed in 'default.nix'.

---

### Installation 💽
```
# Desktop
sudo nixos-rebuild switch --flake github:***REMOVED***/dotfiles#desktop

# Laptop
sudo nixos-rebuild switch --flake github:***REMOVED***/dotfiles#laptop

# Server
sudo nixos-rebuild switch --flake github:***REMOVED***/dotfiles#server
```
