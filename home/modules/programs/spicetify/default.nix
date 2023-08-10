{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {

  options.homeModules.programs.spicetify.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.programs.spicetify.enable {

    # Configuration
    programs.spicetify = let spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default; in {
      enable = true;
      theme = spicePkgs.themes.catppuccin-macchiato;
      colorScheme = "flamingo";
      enabledExtensions = with spicePkgs.extensions; [
        hidePodcasts
        genre
        songStats
        volumePercentage
      ];
    };
  };
}