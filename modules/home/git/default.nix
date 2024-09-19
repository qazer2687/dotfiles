{
  lib,
  config,
  ...
}: {
  options.modules.git.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.git.enable {
    programs.git = {
      enable = true;
      userName = "qazer2687";
      userEmail = "114782572+qazer2687@users.noreply.github.com";
    };

    home.file.".ssh/config".text = ''
      Host github.com
        Hostname ssh.github.com
        Port 443
  '';
  };
}
