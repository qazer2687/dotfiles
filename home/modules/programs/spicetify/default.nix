{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {

  # Imports
  imports = [inputs.spicetify-nix.homeManagerModule];

  options.homeModules.programs.spicetify.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.programs.spicetify.enable {
    # Installation
   # home.packages = with pkgs; [spotify];

    # Configuration
    programs.spicetify = let spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default; in {
      enable = true;
      theme = spicePkgs.themes.Dribbblish;
      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        shuffle
        hidePodcasts
      ];
    #  colorScheme = "custom";
      
     # customColorScheme = {
     #   text = "ffffff";
     #   subtext = "F0F0F0";
     #   sidebar-text = "e0def4";1
     #   main = "191724";
     #   sidebar = "0a0a0a";
     #   player = "0f0f0f";
     #   card = "191724";
      #  shadow = "1f1d2e";
     #   selected-row = "050505";
     #   button = "31748f";
     #   button-active = "31748f";
     #   button-disabled = "555169";
     #   tab-active = "ebbcba";
     #   notification = "1db954";
     #   notification-error = "eb6f92";
     #   misc = "6e6a86";
     # };
    };
  };
}