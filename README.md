# NixOS Dotfiles [![Nix Evaluation](https://github.com/alexvasilkovski/dotfiles/actions/workflows/nix.yml/badge.svg)](https://github.com/alexvasilkovski/dotfiles/actions/workflows/nix.yml)

This is my Nix Flake, containing three system configurations:
- #desktop
- #laptop
- #server

#### <b> Warning: All configurations are using the Colemak keyboard layout, this can be changed in 'default.nix'.

---

### Installation 💽
```
# Desktop
sudo nixos-rebuild switch --flake github:alexvasilkovski/dotfiles#desktop

# Laptop
sudo nixos-rebuild switch --flake github:alexvasilkovski/dotfiles#laptop

# Server
sudo nixos-rebuild switch --flake github:alexvasilkovski/dotfiles#server
```
