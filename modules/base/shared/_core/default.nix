{
  lib,
  config,
  inputs,
  self,
  ...
}: {
  options.modules.core.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.core.enable {
    ########## NIX ##########

    nix = let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org/"
        "https://nixos-apple-silicon.cachix.org"
        "https://hyprland.cachix.org"
        "https://attic.xuyh0120.win/lantian"
        "https://cache.xinux.uz"
      ];
    in {
      settings = {
        inherit substituters;
        trusted-substituters = substituters;

        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "nixos-apple-silicon.cachix.org-1:8psDu5SA5dAD7qA0zMy5UT292TxeEPzIz8VVEr2Js20="
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
          "cache.xinux.uz:BXCrtqejFjWzWEB9YuGB7X2MV4ttBur1N8BkwQRdH+0="
        ];

        experimental-features = [
          "nix-command"
          "flakes"
        ];
        flake-registry = "";
        # https://github.com/NixOS/nix/issues/9574
        nix-path = config.nix.nixPath;
        keep-derivations = true;
        keep-outputs = true;
        auto-optimise-store = true;
        sandbox = true;
        # Required for remote builds.
        require-sigs = false;
      };
      channel.enable = false;
      registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    };

    ########## NIXPKGS ##########

    nixpkgs = {
      config = {
        # Permit the installation of
        # packages with unfree licences.
        allowUnfree = true;
      };
      overlays = [
        self.overlays.additions
        # Enabling the modifications overlay for all machines
        # means that any package which has an overlay will be
        # changed for all hosts. I may remove this in the future
        # but it works fine with my configuration for now.
        self.overlays.modifications

        # inputs.<name>.overlay...
      ];
    };

    ########## NETWORKING ##########

    # Tailscale
    #services.tailscale.enable = true;
    networking = {
      # Allow all the IP's in the tailscale subnet to bypass firewall.
      firewall.extraInputRules = ''
        -A INPUT -i tailscale0 -j ACCEPT
      '';
    };

    /*
    systemd = {
      services.NetworkManager-wait-online.enable = false;
      # Disable the service because it hangs on boot.
      services.NetworkManager-dispatcher.enable = false;
    };
    */

    # Block AI-related domains.
    services.dnsmasq = {
      enable = true;
      settings = {
        no-resolv = true;
        server = [
          "/ts.net/100.100.100.100"
          "//100.100.100.100"
          "1.1.1.1"
          "9.9.9.9"
        ];
        address = map (d: "/${d}/0.0.0.0") [
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
      };
    };

    ########## KEYMAP ##########

    console.keyMap = "colemak";
    services.xserver.xkb = {
      layout = "gb";
      variant = "colemak";
    };

    ########## LOCALE ##########

    time.timeZone = "Europe/London";
    i18n.defaultLocale = "en_GB.UTF-8";

    ########## SOPS ##########

    sops = {
      defaultSopsFormat = "yaml";
      defaultSopsFile = ../../../secrets/default.yaml;
      age.keyFile = "/home/alex/.config/sops/age/keys.txt";
    };
  };
}
