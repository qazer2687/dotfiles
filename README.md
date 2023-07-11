# Qazer's NixOS Dotfiles ~ V3 | [![Nix Evaluation](https://github.com/alexvasilkovski/dotfiles/actions/workflows/nix.yml/badge.svg)](https://github.com/alexvasilkovski/dotfiles/actions/workflows/nix.yml)

This is my personal [Nix flake](https://nixos.wiki/wiki/Flakes) for my desktop, laptop and server.

> __Warning__
>
>This README is a breakdown of V3, which has not been released yet. Not all features described are implemented yet.


## Features 🛠️

- Flake has multiple outputs for different use-cases.
- Implements root impermanence and home persistance.
- zRAM for greater swap performance.
- Partitioned with an EXT4 filesystem.
- Uses Sops-Nix to store secrets.
- Includes TLP and Powertop for battery savings.
- Utilizes Home-Manager to configure users.
- Has a full-fledged i3 environment.
- Comes with Github Actions for flake validation.
- Nix-Direnv for programming dependencies and tools.

## Structure 🧱

- `flake.nix`: Entrypoint for hosts and home configurations. Also exposes a
  devshell for boostrapping (`nix develop` or `nix-shell`).
- `hosts`: NixOS Configurations, accessible via `nixos-rebuild --flake`.
  - `common`: Shared configurations consumed by the machine-specific ones.
    - `global`: Configurations that are globally applied to all my machines.
    - `optional`: Opt-in configurations my machines can use.
  - `jade`: Desktop - 16GB RAM, R9 3900x, RTX 2070S
    - `configs`: Specific configuration files for packages unique to this machine. (Moving to common/optional soon...)
  - `ruby`: Laptop - 8GB RAM, I5 8350u
    - `configs`: Specific configuration files for packages unique to this machine. (Moving to common/optional soon...)
  - `opal`: Server - Coming Soon...
- `modules`: Many modules (with options) which are used in my configurations.

## About 📕

These dotfiles are my own and therefore cater to my own specific needs.
However, you are always welcome to implement your own features and play around with my configurations.

| ⚠️ Warnings ⚠️ |
|---|
|All hosts use the "Colemak" keyboard layout in the console and graphical interface. This can be changed in the `colemak.nix` module.|
|Home-Manager is used as part of the main configuration and is not interacted with directly.|
|Jade is configured to use the Nvidia Graphics Drivers, if you have an AMD card then you can change the drivers in the `nvidia.nix` module.|

## Bootstrapping 🏗️

To build a specific system configuration, you can use the:
`nixos-rebuild switch --flake github:alexvasilkovski/dotfiles#<output>`
command, along with a suitable output (one of the many hosts defined in the flake structure).

## Secrets 🔐

For deployment secrets I'm using [`sops-nix`](https://github.com/Mic92/sops-nix). All secrets are encrypted with an Age key which I have stored in my brain.

## Tooling & Applications 🧰

**TUI:**

- Neovim
- TLP
- Powertop
- Git
- Nitch
- Ncdu
- Bat
- Age
- Bash + Starship
- BacklightCTL
- Redshift

**GUI:**

- Obsidian
- Anki
- Firefox
- Discord
- Alacritty
- Pavucontrol
- Steam
- Lutris

**Services:**

- Gitea
- Portainer
- SearXNG
- Minecraft
- Dashboard

**Others:**

- Sops-Nix
- Impermanence
- Home-Manager

## Credit ❤️

- **Misterio** for inspiring this README.
- **NobbZ**, **Gerg** & **Camellia** for all the support I've recieved along the way.
- **Raf** for some Nix that helped with boot performance.
