{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.core.enable = lib.mkEnableOption "";

  # This module is a replacement to having a shared
  # folder in the homes directory.
  #
  # All options defined in this module are meant to be
  # enabled on all hosts INCLUDING SERVER HOSTS.
  #
  # All settings defined here can be overridden using
  # lib.mkForce in the configuration files for specific
  # hosts, although if you really need to do that, it
  # probably doesn't belong in this file.
  # 
  # Not everything here does belong on a server such as
  # theming but I'm not too concerned about it. If it
  # becomes an issue in the future I can split the file
  # into a core and a graphical option for other settings.

  config = lib.mkIf config.modules.core.enable {
   
    ########## THEME ##########
    
    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 16;
    };

    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
      iconTheme = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };
      cursorTheme = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };
      gtk3 = {
        extraConfig.gtk-application-prefer-dark-theme = true;
      };
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        gtk-theme = "Adwaita-dark";
        color-scheme = "prefer-dark";
      };
    };

    qt = {
      enable = true;
      platformTheme.name = "adwaita";
      style.name = "adwaita-dark";
    };
    
    ########## GIT ##########
    
    programs.git = {
      enable = true;
      userName = "qazer2687";
      userEmail = "114782572+qazer2687@users.noreply.github.com";
      # Force git to use SSH instead of HTTPS globally.
      # https://news.ycombinator.com/item?id=17793099
      extraConfig = {
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
      # which is managed by sops. I know it's not technically correct to say 'ssh-keys' given it's a single one
      # but this serves as a proof of concept for the time being.
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
      sopsFile = ../../../secrets/ssh-keys.yaml;
      mode = "0400";
      path = "${config.home.homeDirectory}/.config/nix/ssh-keys";
      key = "github-qazer2687";
    };

    # Access Tokens
    sops.secrets.access-tokens = {
      sopsFile = ../../../secrets/access-tokens.yaml;
      mode = "0400";
      path = "${config.home.homeDirectory}/.config/nix/access-tokens.conf";
      key = "qazer2687";
    };

    # Load the from the sops plaintext file into conf.nix.
    nix.extraOptions = "!include ${config.sops.secrets."access-tokens".path}";
    
    ########## DIRENV ##########
    
    programs.direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
      config = {
        global = {
          disable_stdin = true;
          warn_timeout = 0;
          hide_env_diff = true;
        };
      };
    };
    
    ########## PACKAGES ##########
    
    home.packages = let   
      fonts = with pkgs; [
        noto-fonts-color-emoji
        noto-fonts-cjk-sans
  
        atkinson-hyperlegible
        agave
        terminus_font
        departure-mono
        eb-garamond
        fixedsys-excelsior
        monaspace
        pragmatapro
  
        nerd-fonts.fira-code
        nerd-fonts.fira-mono
        nerd-fonts.iosevka
        nerd-fonts.liberation
        nerd-fonts.jetbrains-mono
      ];
     
      utilities = [
        (pkgs.writeShellApplication {
          name = "webcam";
          runtimeInputs = with pkgs; [mpv];
          text = ''
            mpv av://v4l2:/dev/video0 --profile=low-latency --untimed --no-osc --no-input-default-bindings --cache=no --vf=hflip > /dev/null 2>&1 &
          '';
        })
        (pkgs.writeShellApplication {
          name = "screenshot";
          runtimeInputs = with pkgs; [
            grim
            slurp
            wl-clipboard
          ];
          text = ''
            grim -g "$(slurp -b 00000055 -c ffffffff)" - | wl-copy -t image/png
          '';
        })
      ];
    in fonts ++ utilities;   
    
    ########## MISC ##########
    
    # Better 'ls' implementation.
    programs.eza.enable = true;
    home.shellAliases = {
      "ls" = "eza --colour=always --icons=always --all";
    };
    
    # Better 'cd' implementation.
    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
    
  };
}
