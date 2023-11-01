{lib, ...}: let
  inherit (lib) mkDefault;
in {
  # System State Version
  system.stateVersion = mkDefault "23.05";

  # Allow Unfree Software
  nixpkgs.config.allowUnfree = mkDefault true;

  # Nix Settings & Experimental Features
  nix.settings = {
    experimental-features = mkDefault [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = mkDefault true;
    keep-derivations = mkDefault true;
    keep-outputs = mkDefault true;
    sandbox = mkDefault false;
  };

  # Locale
  time.timeZone = mkDefault "Europe/London";
  i18n.defaultLocale = mkDefault "en_GB.UTF-8";

  # Environment
  environment = {
    defaultPackages = lib.mkForce [];
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    interactiveShellInit = ''
      alias check='alejandra -q **/* && deadnix -e && statix fix'
      alias rebuild='sudo nixos-rebuild switch --flake .#$(hostname)'
      alias rebuild-git='sudo nixos-rebuild switch --flake github:alexvasilkovski/dotfiles#$(hostname)'
    '';
  };
}
