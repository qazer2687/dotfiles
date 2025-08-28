{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.nh.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.nh.enable {
    programs.nh = {
      enable = true;
      clean.enable = false;
      flake = "/home/alex/Code/dotfiles";
    };
    programs.bash.shellAliases = {
      "rebuild" = "nh os switch github:qazer2687/dotfiles -H $(hostname) -- --refresh --option eval-cache false";
    };
  };
}
