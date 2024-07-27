{
  lib,
  config,
  ...
}: {
  options.modules.nh.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.nh.enable {
    programs.nh = {
      enable = true;
      clean.enable = true;
      flake = "/home/alex/Code/dotfiles";
    };
  };
}
