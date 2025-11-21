{
  lib,
  config,
  ...
}: {
  options.modules.git.enable = lib.mkEnableOption "";
  config = lib.mkIf config.modules.git.enable {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "qazer2687";
          email = "114782572+qazer2687@users.noreply.github.com";
        };
        url."git@github.com:" = {
          insteadOf = "https://github.com/";
        };
      };
    };
    # Aliases to convert a git repository from https to ssh and vice versa.
    # https://stackoverflow.com/a/52348042
    home.shellAliases = {
      "ssh2https" = "git remote set-url origin $(git remote get-url origin | sed 's/^git@\(.*\):\/*\(.*\).git/https:\/\/\1\/\2.git/')";
      "https2ssh" = "git remote set-url origin $(git remote get-url origin | sed 's/^https:\/\/\([^\/]*\)\/\(.*\).git/git@\1\:\2.git/')";
    };
    home.file.".ssh/config" = {
      # This is a fix from stackoverflow that allows connecting to github over SSH when port 22 is blocked.
      # https://stackoverflow.com/questions/7953806/github-ssh-via-public-wifi-port-22-blocked
      # I also add an identity file which allows me to use my github ssh key to authenticate with github
      # which is managed by sops.
      text = ''
        Host github.com
          Hostname ssh.github.com
          Port 443
          IdentityFile ~/.config/nix/ssh-keys
      '';
      # This is a fix from github that handles the 'bad owner or permissions on ~/.ssh/config' error.
      # https://github.com/nix-community/home-manager/issues/322#issuecomment-1856128020
      target = ".ssh/config_source";
      onChange = ''
        cat ~/.ssh/config_source > ~/.ssh/config && chmod 400 ~/.ssh/config
      '';
    };
    # SSH Keys
    sops.secrets.ssh-keys = {
      sopsFile = ../../../../secrets/ssh-keys.yaml;
      mode = "0400";
      path = "${config.home.homeDirectory}/.config/nix/ssh-keys";
      key = "github-qazer2687";
    };
    # Access Tokens
    sops.secrets.access-tokens = {
      sopsFile = ../../../../secrets/access-tokens.yaml;
      mode = "0400";
      path = "${config.home.homeDirectory}/.config/nix/access-tokens.conf";
      key = "qazer2687";
    };
    # Load the from the sops plaintext file into conf.nix.
    nix.extraOptions = "!include ${config.sops.secrets."access-tokens".path}";
  };
}