{ pkgs, lib, ... }: let
  warpOverlay = final: prev: {
    warp-terminal-aarch64 = prev.warp-terminal.overrideAttrs (finalAttrs: rec {
      src = pkgs.fetchurl {
        url = "https://releases.warp.dev/stable/v${finalAttrs.version}/warp-terminal-v${finalAttrs.version}-1-aarch64.pkg.tar.zst";
      };

      meta = with lib; {
        inherit (finalAttrs.meta) description homepage license sourceProvenance maintainers;
        platforms = finalAttrs.meta.platforms ++ [ "aarch64-linux" ];
      };
    });
  };
in {
  imports = [
    ../../modules/home
  ];

  nixpkgs.overlays = [ warpOverlay ];

  home.packages = with pkgs; [
    obsidian
    nautilus
    gammastep
    fragments
    vesktop
    warp-terminal-aarch64
  ];

  modules = {
    # Environment
    sway.enable = true;
    waybar.enable = true;
    foot.enable = true;
    mako.enable = true;
    wofi.enable = true;
    dark.enable = true;
    firefox.enable = true;
    fish.enable = true;

    # CLI Tools
    bat.enable = true;
    eza.enable = true;

    # Development
    vscode.enable = true;
    git.enable = true;
    direnv.enable = true;
    #starship.enable = true;
  };

  home.stateVersion = "24.11";
  home.homeDirectory = "/home/alex";

  sops.defaultSopsFile = ../../../secrets/default.yaml;
  sops.age.sshKeyPaths = ["/home/alex/.ssh/id_ed25519"];
}
