{
  lib,
  config,
  inputs,
  outputs,
  ...
}: {
  
  options.modules.core.enable = lib.mkEnableOption "";

  # This module is a replacement to having a shared
  # folder in the hosts directory.
  #
  # All options defined in this module are meant to be
  # enabled on all hosts.
  #
  # All settings defined here can be overridden using
  # lib.mkForce in the configuration files for specific hosts.

  config = lib.mkIf config.modules.core.enable {
    nix = let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in {
      settings = {
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

    nixpkgs = {
      config = {
        # Permit the install of packages
        # that have unfree licences.
        allowUnfree = true;
      };
      overlays = [
        outputs.overlays.additions
        # Enabling the modifications overlay for all machines
        # means that any package which has an overlay will be
        # changed for all hosts. I may remove this in the future
        # but it works fine with my configuration for now.
        outputs.overlays.modifications
      ];
    };

    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = true;
      };
    };

    console.keyMap = "colemak";
    services.xserver.xkb = {
      layout = "gb";
      variant = "colemak";
    };

    time.timeZone = "Europe/London";
    i18n.defaultLocale = "en_GB.UTF-8";

    programs.dconf.enable = true;
    security.polkit.enable = true;
    systemd.coredump.enable = false;


    sops.defaultSopsFormat = "yaml";
    sops.defaultSopsFile = ../../secrets/default.yaml;
    sops.age.keyFile = "~/.config/sops/age/keys.txt";

    environment = {
      defaultPackages = lib.mkForce [];
      sessionVariables = {
        # Additional session variables can be used via
        # delcaring environment.sessionVariables in
        # the configuration for a specific host.
        NIXPKGS_ALLOW_UNFREE = "1";
        NIXPKGS_ALLOW_INSECURE = "1";
      };
    };
  };
}
