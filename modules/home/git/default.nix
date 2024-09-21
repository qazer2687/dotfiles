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

    #? This is a fix from stackoverflow that allows connecting to github over SSH when port 22 is blocked.
    #? https://stackoverflow.com/questions/7953806/github-ssh-via-public-wifi-port-22-blocked
    home.file.".ssh/config".text = ''
      Host github.com
        Hostname ssh.github.com
        Port 443
  '';
  };
}
