{
  lib,
  config,
  ...
}: {
  options.homeModules.bash.enable = lib.mkEnableOption "";

  config = lib.mkMerge [
    (lib.mkIf config.homeModules.bash.enable {
      programs.bash = {
        enable = true;
        enableCompletion = true;
      };
    })

    (lib.mkIf config.homeModules.bash.swayProfile.enable {
       programs.bash = {
        profileExtra = ''
          
        '';
      };
    })
  ];
}