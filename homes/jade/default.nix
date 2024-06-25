{pkgs, ...}: {
  imports = [
    ../../modules/home
  ];

  home.packages = with pkgs; [
    obsidian
    gnome.nautilus
    obs-studio
    armcord
    lunar-client
    vlc
  ];

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };

    taps = [
      "kadena-io/pact"
    ];
    brews = [
      "openssl"
      "kadena-io/pact/pact"
      "z3"
    ];

    casks = [
      "docker"
      "drivedx"
      { name = "firefox"; greedy = true; }
      "hazel"
      "iterm2"
      "keyboard-maestro"
      "launchbar"
      "ollama"
      "vmware-fusion"
      "wireshark"
    ] ++ lib.optionals (hostname != "athena") [
      "1password"
      "1password-cli"
      "anki"
      { name = "arc"; greedy = true; }
      "asana"
      "audacity"
      "backblaze"
      "backblaze-downloader"
      { name = "brave-browser"; greedy = true; }
      "carbon-copy-cloner"
      "choosy"
      # "datagraph"                 # Use DataGraph in App Store
      "dbvisualizer"
      "devonagent"
      "devonthink"
      "discord"
      "element"
      "expandrive"
      "fantastical"
      "gpg-suite"
      "grammarly-desktop"
      "lectrote"
      # "macwhisper"                # Use Whisper Transcription in AppStore
      # "marked"                    # Use Marked 2 in AppStore
      "mellel"
      "netdownloadhelpercoapp"
      "notion"
      # "omnigraffle"               # Stay at version 6
      { name = "opera"; greedy = true; }
      "pdf-expert"
      "sage"
      # "screenflow"                # Stay at version 9
      "signal"
      "slack"
      # "soulver"                   # Use Soulver 3 in App Store
      "soulver-cli"
      "steam"
      "suspicious-package"
      "tagspaces"
      "telegram"
      "thinkorswim"
      "tor-browser"
      "ukelele"
      "unicodechecker"
      "vagrant"
      "vagrant-manager"
      "vagrant-vmware-utility"
      "virtual-ii"
      "visual-studio-code"
      { name = "vivaldi"; greedy = true; }
      "vlc"
      "whatsapp"
      "xnviewmp"
      "yubico-yubikey-manager"
      { name = "zoom"; greedy = true; }
      "zotero"
      "zulip"
    ] ++ lib.optionals (hostname == "athena") [
      "openzfs"
    ] ++ lib.optionals (hostname == "hermes") [
      "chronoagent"
    ] ++ lib.optionals (hostname == "vulcan") [
      "fujitsu-scansnap-home"
      "geektool"
      "gzdoom"
      "ledger-live"
      "raspberry-pi-imager"
      "chronosync"
    ];

  modules = {
    # Environment
    i3.enable = true;
    alacritty.enable = true;
    git.enable = true;
    dark.enable = true;
    neovim.enable = true;
    firefox.enable = true;
    fish.enable = true;
    polybar.enable = true;
    dunst.enable = true;

    # Development
    vscode.enable = true;
    emacs.enable = true;

    # Gaming
    prismlauncher.enable = true;
  };

  home.stateVersion = "23.05";
  home.homeDirectory = "/home/alex";

  sops.defaultSopsFile = ../../../secrets/default.yaml;
  sops.age.sshKeyPaths = ["/home/alex/.ssh/id_ed25519"];
}
