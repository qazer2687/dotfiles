{pkgs, ...}: {
  imports = [
    ../../hardware/coal
  ];

  networking.hostName = "coal";

  users.users = {
    alex = {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel" "video" "audio" "dialout"];
      shell = pkgs.fish;
      hashedPassword = "$6$qRDf73LqqlnrtGKd$fwNbmyhVjAHfgjPpM.Wn8YoYVbLRq1oFWN15fjP3b.cVW8Dv3s/7q8NY4WBYY7x1Xe71S.AHpuqL1PY6IJe0x1";
    };
  };

  programs.fish.enable = true;

  services.fwupd.enable = true;

  # Disable power button (short press) and sleep/suspend button.
  services.logind.settings.Login = {
    HandlePowerKey = "ignore";
    HandleSuspendKey = "ignore";
    HandleHibernateKey = "ignore";
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "mitigations=off"
      "i915.enable_guc=3"
      "i915.fastboot=1"
      "i915.enable_dc=0"
      "i915.enable_psr=0"
      "psmouse.synaptics_intertouch=0"
    ];
  };

  # Nautilus trash support.
  services.gvfs.enable = true;

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 24 * 1024;
    }
  ];

  # Autologin and hide getty messages.
  services.getty = {
    autologinUser = "alex";
    extraArgs = [
      "--skip-login"
      "--nonewline"
      "--noissue"
      "--noclear"
      "--nohostname"
    ];
  };

  programs.sway = {
    enable = true;
  };

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      XDG_SESSION_TYPE = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    };
    systemPackages = with pkgs; [
      nautilus
      ffmpegthumbnailer
      ffmpeg-headless
      gdk-pixbuf
    ];
  };

  environment.pathsToLink = [
    "share/thumbnailers"
  ];

  modules = {
    core.enable = true;
    dbus.enable = true;
    fontconfig.enable = true;
    keyring.enable = true;
    nh.enable = true;
    sudo-rs.enable = true;
    systemd-boot.enable = true;
    xdg.enable = true;
    networkmanager.enable = true;
    tailscale.enable = true;
    keyd.enable = true;
    pipewire.enable = true;
    tlp.enable = true;
    upower.enable = true;
    easyeffects.enable = true;
    libinput.enable = true;
    flatpak.enable = true;
  };

  # Did you read the comment?
  system.stateVersion = "26.05";
  
  networking.hosts."0.0.0.0" = builtins.concatMap (d: [ d "www.${d}" ]) [
    # chat
    "openai.com" "chatgpt.com" "sora.com"
    "claude.ai" "claude.com" "anthropic.com"
    "gemini.google.com" "bard.google.com" "aistudio.google.com"
    "notebooklm.google.com" "labs.google" "deepmind.google"
    "copilot.microsoft.com" "perplexity.ai" "grok.com" "x.ai"
    "meta.ai" "poe.com" "pi.ai" "inflection.ai" "you.com"
    "phind.com" "duck.ai" "genspark.ai" "felo.ai" "andisearch.com"
    "mistral.ai" "cohere.com" "ai21.com" "01.ai"
    "character.ai" "chai-research.com" "janitorai.com" "replika.com"
    "aidungeon.com" "novelai.net"
    "deepseek.com" "kimi.com" "kimi.ai" "moonshot.ai" "moonshot.cn"
    "z.ai" "zhipuai.cn" "bigmodel.cn" "chatglm.cn"
    "qwen.ai" "qwenlm.ai" "tongyi.aliyun.com" "doubao.com"
    "yuanbao.tencent.com" "yiyan.baidu.com"
    "minimax.io" "minimaxi.com" "hailuoai.com"
    "stepfun.com" "baichuan-ai.com" "manus.im"
  
    # platforms
    "huggingface.co" "hf.co" "groq.com" "together.ai" "openrouter.ai"
    "replicate.com" "fireworks.ai" "fal.ai" "lmarena.ai"
  
    # coding
    "cursor.com" "cursor.sh" "windsurf.com" "codeium.com"
    "lovable.dev" "bolt.new" "v0.dev" "v0.app" "tabnine.com"
    "githubcopilot.com" "kiro.dev" "cognition.ai" "devin.ai"
  
    # media
    "midjourney.com" "stability.ai" "runwayml.com" "pika.art"
    "lumalabs.ai" "klingai.com" "kling.ai" "leonardo.ai"
    "ideogram.ai" "civitai.com" "playground.com" "krea.ai"
    "higgsfield.ai" "heygen.com" "synthesia.io" "invideo.io"
    "openart.ai" "nightcafe.studio" "craiyon.com" "tensor.art"
    "seaart.ai" "firefly.adobe.com"
  
    # audio
    "suno.com" "udio.com" "elevenlabs.io" "murf.ai"
  
    # writing
    "jasper.ai" "copy.ai" "writesonic.com" "quillbot.com"
    "grammarly.com" "rytr.me" "sudowrite.com" "deepai.org"
    "gamma.app" "tome.app" "beautiful.ai" "otter.ai"
    "fireflies.ai" "elicit.com" "consensus.app"
  ];
}
