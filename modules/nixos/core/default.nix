{
  lib,
  config,
  ...
}: {
  options.modules.core.enable = lib.mkEnableOption "";

  ## This module is a replacement to having a shared
  ## folder in the hosts directory.
  ##
  ## All options defined in this module are meant to be
  ## enabled by all hosts.
  ##
  ## All settings are enabled with lib.mkDefault meaning
  ## that you can override them with lib.mkForce in the
  ## configuration files for specific hosts.

  config = lib.mkIf config.modules.core.enable {

    # Nix
    nix = let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in {
      settings = {
        experimental-features = lib.mkDefault [
          "nix-command"
          "flakes"
        ];
        ## Disable global registry.
        flake-registry = lib.mkDefault "";
        ## https://github.com/NixOS/nix/issues/9574
        nix-path = lib.mkDefault config.nix.nixPath;
        keep-derivations = lib.mkDefault true;
        keep-outputs = lib.mkDefault true;
        auto-optimise-store = lib.mkDefault true;
        sandbox = lib.mkDefault true;
        ## Required for remote builds.
        require-sigs = lib.mkDefault false;
      };
      ## Disable channels.
      channel.enable = lib.mkDefault false;
      ## Make the flake registry and
      ## nix path match flake inputs.
      registry = lib.mkDefault lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
      nixPath = lib.mkDefault lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

    # Nixpkgs
    nixpkgs = {
      config = {
        ## Permit the install of packages
        ## that have unfree licences.
        allowUnfree = lib.mkDefault true;
      };
      overlays = lib.mkDefault [
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
    time.timeZone = lib.mkDefault "Europe/London";
    i18n.defaultLocale = lib.mkDefault "en_GB.UTF-8";

    # Sops
    sops.defaultSopsFile = lib.mkDefault ./secrets/default.yaml;

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
