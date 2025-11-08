{
  lib,
  config,
  inputs,
  self,
  ...
}: {
  options.modules.core.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.core.enable {
    ########## NIX ##########

    nix = let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in {
      settings = {
        trusted-substituters = [
          "https://hyprland.cachix.org"
          "https://cache.garnix.io"
          "https://nixos-apple-silicon.cachix.org"
        ];

        trusted-public-keys = [
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nixos-apple-silicon.cachix.org-1:8psDu5SA5dAD7qA0zMy5UT292TxeEPzIz8VVEr2Js20="
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

    ########## NETWORKING ##########

    # Tailscale
    #services.tailscale.enable = true;
    networking = {
      # Allow all the IP's in the tailscale subnet to bypass firewall.
      firewall.extraInputRules = ''
        -A INPUT -i tailscale0 -j ACCEPT
      '';
    };

    /*
    systemd = {
      services.NetworkManager-wait-online.enable = false;
      # Disable the service because it hangs on boot.
      services.NetworkManager-dispatcher.enable = false;
    };
    */

    # Block AI-related domains.
   /* networking.extraHosts = ''
      127.0.0.1 chat.openai.com
      127.0.0.1 openai.com
      127.0.0.1 claude.ai
      127.0.0.1 poe.com
      127.0.0.1 bard.google.com
      127.0.0.1 gemini.google.com
      127.0.0.1 chatgpt.com
      127.0.0.1 perplexity.ai
      127.0.0.1 copilot.microsoft.com
    '';*/

    ########## KEYMAP ##########

    console.keyMap = "colemak";
    services.xserver.xkb = {
      layout = "gb";
      variant = "colemak";
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
  };
}
