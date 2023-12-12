# Qazer's NixOS Dotfiles ~ V4 | [![Nix Evaluation](https://github.com/***REMOVED***/dotfiles/actions/workflows/nix.yml/badge.svg)](https://github.com/***REMOVED***/dotfiles/actions/workflows/nix.yml)

This is my personal [Nix flake](https://nixos.wiki/wiki/Flakes) for my different machines.

## Hosts & Structure 💾

- 🟩 `jade`    : Desktop
- 🟥 `ruby`    : Laptop
- ⬛ `opal`    : Server
- 🟪 `kunzite` : Phone
- 🟦 `topaz`   : Brother's Desktop
- 🟨 `citrine` : x86-64 VM
- ⬜ `quartz`  : AArch64 VM

```
┌── flake.nix
├── flake.lock
├── home
│   ├── configurations
│   │   ├── <hosts>
│   │   └── shared
│   └── modules
├── nixos
│   ├── configurations
│   │   ├── <hosts>
│   │   └── shared
│   └── modules
├── .sops.yaml
└── secrets
```

## Bootstrapping 🏗️

To install a specific NixOS system configuration from this repository, you can use the following command:
```bash
nixos-rebuild switch --flake github:***REMOVED***/dotfiles#<output>
```
Replace `<output>` with the desired system configuration you want to use from the flake.
