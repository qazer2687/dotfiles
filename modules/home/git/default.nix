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

    home.file.".ssh/config" = {
      #? This is a fix from stackoverflow that allows connecting to github over SSH when port 22 is blocked.
      #? https://stackoverflow.com/questions/7953806/github-ssh-via-public-wifi-port-22-blocked
      text = ''
        Host github.com
          Hostname ssh.github.com
          Port 443
      '';
      #? This is a fix from github that handles the 'bad owner or permissions on ~/.ssh/config' error.
      #? https://github.com/nix-community/home-manager/issues/322#issuecomment-1856128020
      onChange = ''
        echo "${config.home.file.".ssh/config".text}" > ~/.ssh/config
        chmod 400 ~/.ssh/config
      '';
    };
  };
}
