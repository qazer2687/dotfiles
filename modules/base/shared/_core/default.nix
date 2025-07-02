{
  lib,
  config,
  inputs,
  self,
  pkgs,
  ...
}: {
  options.modules.core.enable = lib.mkEnableOption "";

  # This module is a replacement to having a shared
  # folder in the hosts directory.
  #
  # All options defined in this module are meant to be
  # enabled on all hosts INCLUDING SERVER HOSTS.
  #
  # All settings defined here can be overridden using
  # lib.mkForce in the configuration files for specific
  # hosts, although if you really need to do that, it
  # probably doesn't belong in this file.

  config = lib.mkIf config.modules.core.enable {
    ########## NIX ##########

    nix = let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in {
      settings = {
        trusted-substituters = [
          #"https://hyprland.cachix.org"
          "https://cache.garnix.io"
        ];

        trusted-public-keys = [
          #"hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        ];

        experimental-features = [
          "nix-command"
          "flakes"
        ];
        flake-registry = "";
        # https://github.com/NixOS/nix/issues/9574
        nix-path = config.nix.nixPath;
        keep-derivations = true;
        keep-outputs = true;
        auto-optimise-store = true;
        sandbox = true;
        # Required for remote builds.
        require-sigs = false;
      };
      channel.enable = false;
      registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

    ########## NIXPKGS ##########

    nixpkgs = {
      config = {
        # Permit the installation of
        # packages with unfree licences.
        allowUnfree = true;
      };
      overlays = [
        self.overlays.additions
        # Enabling the modifications overlay for all machines
        # means that any package which has an overlay will be
        # changed for all hosts. I may remove this in the future
        # but it works fine with my configuration for now.
        self.overlays.modifications

        # inputs.<name>.overlay...
      ];
    };

    ########## BOOTLOADER ##########

    boot.loader.systemd-boot.enable = true;
    # Pressing ESC on boot will bring up the bootloader menu.
    boot.loader.timeout = 0;
    environment.etc = {
      "issue" = {
        text = "[?12l[?25h";
        mode = "0444";
      };
    };

    ########## NETWORKING ##########

    # Tailscale
    services.tailscale.enable = true;
    networking = {
      networkmanager.enable = true;
      # Allow all the IP's in the tailscale subnet to bypass firewall.
      firewall.extraInputRules = ''
        -A INPUT -i tailscale0 -j ACCEPT
        -A INPUT -s 100.64.0.0/10 -j ACCEPT
      '';
    };
    systemd = {
      services.NetworkManager-wait-online.enable = false;
      # Disable the service because it hangs on boot.
      services.NetworkManager-dispatcher.enable = false;
    };

    /*
    # Block connections to a few LLM's.
    networking.extraHosts = ''
      127.0.0.1       chat.openai.com
      127.0.0.1       chatgpt.com

      127.0.0.1       claude.ai

      127.0.0.1       gemini.google.com
    '';
    */

    ########## KEYMAP ##########

    console.keyMap = "colemak";
    services.xserver.xkb = {
      layout = "gb";
      variant = "colemak";
    };

    ########## KEYRING ##########

    services.gnome.gnome-keyring.enable = true;
    security.pam.services.login.enableGnomeKeyring = true;

    ########## XDG ##########

    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-wlr
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
      ];
      xdgOpenUsePortal = true;
      config = {
        common = {
          default = ["hyprland" "wlr" "gtk"];
        };
      };
    };

    ########## LOCALE ##########

    time.timeZone = "Europe/London";
    i18n.defaultLocale = "en_GB.UTF-8";

    ########## SOPS ##########

    sops = {
      defaultSopsFormat = "yaml";
      defaultSopsFile = ../../../secrets/default.yaml;
      age.keyFile = "/home/alex/.config/sops/age/keys.txt";
    };

    ########## ENVIRONMENT ##########

    environment = {
      defaultPackages = lib.mkForce [];
      sessionVariables = {
        # Additional session variables can be used via
        # declaring environment.sessionVariables in
        # the configuration for a specific host.
      };
    };

    ########## COMPATIBILITY ##########

    # Support for trash:/// on nautilus.
    services.gvfs.enable = true;

    # iOS Filesystem Support
    services.usbmuxd.enable = true;
    environment.systemPackages = with pkgs;
      [
        ifuse
        libimobiledevice
      ]
      ++
      # Support for heic image preview on nautilus.
      [
        pkgs.libheif
        pkgs.libheif.out
      ];
    environment.pathsToLink = ["share/thumbnailers"];

    ########## MISC ##########

    # EXPERIMENTAL - High performance implementation of DBUS.
    services.dbus = {
      enable = true;
      implementation = "broker";
    };

    # Fix 'command-not-found' error 'failed to open database'.
    programs.command-not-found.enable = false;

    programs.dconf.enable = true;
    security.polkit.enable = true;

    # Less bloated sudo implementation.
    security.sudo.enable = false;
    security.sudo-rs = {
      enable = true;
      wheelNeedsPassword = false;
    };

    # Improved nixos-rebuild implementation.
    programs.nh = {
      enable = true;
      clean.enable = false;
      flake = "/home/alex/Code/dotfiles";
    };

    # OOM Killer
    services.earlyoom.enable = true;

    fonts.fontconfig = {
      enable = true;
      antialias = true;
      subpixel = {
        rgba = "none";
        lcdfilter = "none";
      };
      hinting = {
        enable = true;
        style = "slight";
      };
    };

    # Use dash as /bin/sh. Although the performance boost
    # will be small to negligible, I might as well use it.
    environment.binsh = "${pkgs.dash}/bin/dash";

    # Disable the core dump service.
    systemd.coredump.enable = false;
    # Discard all core dumps.
    boot.kernel.sysctl."kernel.core_pattern" = "/dev/null";

    # Add a global rebuild command to bash for any hosts that aren't using home-manager.
    programs.bash.shellAliases = {
      "rebuild" = "nh os switch github:qazer2687/dotfiles -H $(hostname) -- --refresh --option eval-cache false";
    };
  };
}
