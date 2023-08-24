{
  lib,
  config,
  ...
}: {
  options.homeModules.bash.jade.enable = lib.mkEnableOption "";
  options.homeModules.bash.ruby.enable = lib.mkEnableOption "";

  config = lib.mkMerge [
    (lib.mkIf config.homeModules.bash.jade.enable {
      programs.bash = {
        enable = true;
        enableCompletion = true;
      };
    })

    (lib.mkIf config.homeModules.bash.ruby.enable {
       programs.bash = {
        enable = true;
        enableCompletion = true;
      };
    })
  ];
}