{
  lib,
  config,
  inputs,
  outputs,
  ...
}: {
  options.modules.core.enable = lib.mkEnableOption "";

  ## This module is a replacement to having a shared
  ## folder in the hosts directory.
  ##
  ## All options defined in this module are meant to be
  ## enabled on all hosts.
  ##
  ## All settings defined here can be overridden using
  ## lib.mkForce in the configuration files for specific hosts.

  config = lib.mkIf config.modules.core.enable {
    # Nix
    nix = let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in {
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        ## Disable global registry.
        flake-registry = "";
        ## https://github.com/NixOS/nix/issues/9574
        nix-path = config.nix.nixPath;
        keep-derivations = true;
        keep-outputs = true;
        auto-optimise-store = true;
        sandbox = true;
        ## Required for remote builds.
        require-sigs = false;
      };
      ## Disable channels.
      channel.enable = false;
      ## Make the flake registry and
      ## nix path match flake inputs.
      registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

    # Nixpkgs
    nixpkgs = {
      config = {
        ## Permit the install of packages
        ## that have unfree licences.
        allowUnfree = true;
      };
      overlays = [
        outputs.overlays.additions
        ## Enabling the modifications overlay for all machines
        ## means that any package which has an overlay will be
        ## changed for all hosts. I may remove this in the future
        ## but it works fine with my configuration for now.
        outputs.overlays.modifications
      ];
    };

    # SSH
    services.openssh = {
      enable = true;
      settings = {
        ## Disallow root login over SSH.
        PermitRootLogin = "no";
        ## Allow authenticating with passwords.
        PasswordAuthentication = true;
      };
    };

    # Locale
    time.timeZone = "Europe/London";
    i18n.defaultLocale = "en_GB.UTF-8";

    # DConf
    programs.dconf.enable = true;

    # Sops
    sops.defaultSopsFile = ./secrets/default.yaml;

    # Environment
    environment = {
      defaultPackages = lib.mkForce [];
      sessionVariables = {
        ## Additional session variables can be used via
        ## delcaring environment.sessionVariables in
        ## the configuration for a specific host.
        NIXPKGS_ALLOW_UNFREE = "1";
        NIXPKGS_ALLOW_INSECURE = "1";
      };
    };
  };
}
