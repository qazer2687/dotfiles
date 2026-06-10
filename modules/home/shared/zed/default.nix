{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.zed.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.zed.enable {
    #programs.zed-editor = {
    #  enable = true;
    #  package = pkgs.zed-editor-fhs;
    #};

    home.systemPackages = [
      (pkgs.zed-editor.fhsWithPackages (pkgs: [ pkgs.zlib ]))
    ];

    home.shellAliases = {
      "zed" = "zeditor";
    };
  };
}
