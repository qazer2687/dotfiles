{
  lib,
  config,
  pkgs,
  inputs,
  base16,
  ...
}: let
  scheme = base16 "mountain";

  raw = lib.generators.mkLuaInline;

  dsp = {
    exec  = cmd: raw ''hl.dsp.exec_cmd("${cmd}")'';
    close = raw "hl.dsp.window.close()";
    float = raw ''hl.dsp.window.float({ action = "toggle" })'';
    fullscreen = n: raw "hl.dsp.window.fullscreen(${toString n})";
    layout     = msg: raw ''hl.dsp.layout("${msg}")'';
    focusWorkspace  = ws: raw ''hl.dsp.focus({ workspace = "${toString ws}" })'';
    moveToWorkspace = ws: raw ''hl.dsp.window.move({ workspace = "${toString ws}" })'';
    drag   = raw "hl.dsp.window.drag()";
    resize = raw "hl.dsp.window.resize()";
    raw    = cmd: raw ''hl.dsp.exec_raw("${cmd}")'';
  };

  bind'     = keys: dsp: { _args = [ keys dsp ]; };
  bindOpts' = keys: dsp: opts: { _args = [ keys dsp opts ]; };
in {
  options.modules.hyprland.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.hyprland.enable {
    home.packages = with pkgs; [
      wbg
      brightnessctl
      pamixer
      wlr-randr
      mpvpaper
      obs-cmd
      wtype
      wl-clipboard
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      configType = "lua";

      settings = {
        monitor = [
          { output = "DP-3"; mode = "highres"; position = "auto"; scale = 1; }
        ];

        config = {
          xwayland = {
            force_zero_scaling = true;
          };

          general = {
            # Master/Stack
            layout = "master";

            gaps_in = 1;
            gaps_out = 2;
            border_size = 0;

            # base05 = text, base0E = mauve
            "col.active_border" = "rgba(${scheme.base00}ff)";
            "col.inactive_border" = "rgba(${scheme.base00}ff)";

            resize_on_border = true;
            allow_tearing = true;
          };

          master = {
            mfact = 0.65;
            orientation = "left";
          };

          input = {
            # Mouse/Pointer
            follow_mouse = 0;
            mouse_refocus = false;

            # Keyboard
            kb_layout = "gb";
            kb_variant = "colemak";
            kb_options = "ctrl:nocaps";
            kb_model = "pc105";
          };

          cursor = {
            no_warps = true;
            no_hardware_cursors = true;
            inactive_timeout = 5;
            hide_on_key_press = true;
          };

          render = {
            # Direct scanout attempts to reduce lag when
            # there is only one fullscreen application on a screen.
            direct_scanout = 0;
            new_render_scheduling = true;
          };

          misc = {
            disable_splash_rendering = true;
            disable_hyprland_logo = true;
            vrr = 0;
            # Stop "application not responding" popup on minecraft.
            enable_anr_dialog = false;
          };
        };

        curve = [
          { _args = [ "snap" { type = "bezier"; points = [ [0.2 0] [0 1] ]; } ]; }
        ];

        animation = [
          # Disable top level animations which children will inherit.
          { leaf = "windows"; enabled = false; }
          { leaf = "layers"; enabled = false; }
          { leaf = "fade"; enabled = false; }
          { leaf = "border"; enabled = false; }
          { leaf = "borderangle"; enabled = false; }
          { leaf = "zoomFactor"; enabled = false; }
          #{ leaf = "monitorAdded"; enabled = false; }

          { leaf = "workspaces"; enabled = true; speed = 2; bezier = "snap"; style = "slide"; }
        ];

        # Required for enabling tearing.
        window_rule = [
          { match = { class = ".*"; }; immediate = true; }
          # Gamescope windows cannot handle immediate mode, but you can use the --immediate flag in gamescope command.
          #{ match = { class = "^(gamescope)$"; }; immediate = false; }
        ];

        bind = [
          # Core
          (bind' "SUPER + Return" (dsp.exec "kitty"))
          (bind' "SUPER + E" (dsp.exec "tofi-run | sh"))
          (bind' "SUPER + Q" dsp.close)
          (bind' "SUPER + F" (dsp.fullscreen 0))

          # Workspace Navigation
          (bind' "SUPER + 1" (dsp.focusWorkspace 1))
          (bind' "SUPER + 2" (dsp.focusWorkspace 2))
          (bind' "SUPER + 3" (dsp.focusWorkspace 3))
          (bind' "SUPER + 4" (dsp.focusWorkspace 4))
          (bind' "SUPER + 5" (dsp.focusWorkspace 5))
          (bind' "SUPER + 6" (dsp.focusWorkspace 6))
          (bind' "SUPER + 7" (dsp.focusWorkspace 7))
          (bind' "SUPER + 8" (dsp.focusWorkspace 8))
          (bind' "SUPER + 9" (dsp.focusWorkspace 9))
          (bind' "SUPER + 0" (dsp.focusWorkspace 10))

          # Workspace Manipulation
          (bind' "SUPER + SHIFT + 1" (dsp.moveToWorkspace 1))
          (bind' "SUPER + SHIFT + 2" (dsp.moveToWorkspace 2))
          (bind' "SUPER + SHIFT + 3" (dsp.moveToWorkspace 3))
          (bind' "SUPER + SHIFT + 4" (dsp.moveToWorkspace 4))
          (bind' "SUPER + SHIFT + 5" (dsp.moveToWorkspace 5))
          (bind' "SUPER + SHIFT + 6" (dsp.moveToWorkspace 6))
          (bind' "SUPER + SHIFT + 7" (dsp.moveToWorkspace 7))
          (bind' "SUPER + SHIFT + 8" (dsp.moveToWorkspace 8))
          (bind' "SUPER + SHIFT + 9" (dsp.moveToWorkspace 9))
          (bind' "SUPER + SHIFT + 0" (dsp.moveToWorkspace 10))

          # Window Navigation
          (bind' "SUPER + left" (dsp.raw "cyclenext prev"))
          (bind' "SUPER + right" (dsp.raw "cyclenext"))
          (bind' "SUPER + up" (dsp.raw "cyclenext prev"))
          (bind' "SUPER + down" (dsp.raw "cyclenext"))
          (bind' "SUPER + space" (dsp.layout "swapwithmaster"))

          # Window Manipulation
          (bind' "SUPER + SHIFT + left" (dsp.layout "mfact -0.05"))
          (bind' "SUPER + SHIFT + right" (dsp.layout "mfact +0.05"))

          (bind' "SUPER + SHIFT + F" dsp.float)

          # Quit
          (bind' "SUPER + SHIFT + Q" (dsp.raw "exit"))

          # OBS Replay
          (bind' "SUPER + BACKSPACE" (dsp.exec "obs-cmd --websocket obsws://localhost:4455 replay save"))

          (bind' "SUPER_L" (dsp.exec "pkill -SIGUSR1 waybar"))

          # Whisper
          (bind' "code:191" (dsp.exec "pkill --signal SIGUSR1 -f dictate.py"))

          (bindOpts' "code:191" (dsp.exec "pkill --signal SIGUSR2 -f dictate.py") { released = true; })

          (bindOpts' "SUPER + SUPER_L" (dsp.exec "pkill -SIGUSR2 waybar") { released = true; transparent = true; })

          (bindOpts' "SUPER + mouse:273" dsp.resize { mouse = true; })
          (bindOpts' "SUPER + mouse:272" dsp.drag { mouse = true; })
        ];
      };

      extraConfig = ''
        -- Add extra config here...
        hl.on("hyprland.start", function()
          hl.exec_cmd("hyprlock -q || loginctl terminate-session $XDG_SESSION_ID")
          hl.exec_cmd("pamixer --set-volume 50")
          hl.exec_cmd("waybar")
          hl.exec_cmd("${pkgs.wbg}/bin/wbg -s /home/alex/.config/wallpaper/wallpaper.png")
          --hl.exec_cmd('mpvpaper -o "--loop-file=inf" DP-3 /home/alex/.config/wallpaper/wallpaper.mkv')
          hl.exec_cmd("${pkgs.sunsetr}/bin/sunsetr")
          --hl.exec_cmd("vesktop --start-minimized")
          hl.exec_cmd("${pkgs.bash}/bin/bash -c 'rm -rf $HOME/.config/obs-studio/.sentinel; exec obs --minimize-to-tray --startreplaybuffer'")
          hl.exec_cmd("cd /home/alex/Projects/whisper && /home/alex/Projects/whisper/.venv/bin/python3 dictate.py")
        end)
      '';
    };
  };
}