{
  lib,
  config,
  ...
}: {
  options.modules.hypridle.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.hypridle.enable {
    xdg.configFile."hypr/shaders/dim.frag".text = ''
      #version 300 es

      precision mediump float;

      in vec2 v_texcoord;
      layout(location = 0) out vec4 fragColor;
      uniform sampler2D tex;

      void main() {
        vec4 c = texture(tex, v_texcoord);
        fragColor = vec4(c.rgb * 0.35, c.a);
      }
    '';

    services.hypridle = {
      enable = true;
      settings = {
        listener = [
          {
            timeout = 240;
            # Screen shaders are applied only to the damaged parts of a frame.
            # With fine-grained damage tracking, tiles that repaint get shaded
            # on their own (flashing) and tiles that weren't repainted stay dark
            # after the shader is removed. Force full-screen redraws while the
            # shader is active, then restore normal damage tracking on resume.
            on-timeout = "hyprctl eval 'hl.config({ debug = { damage_tracking = 0 }, decoration = { screen_shader = \"/home/alex/.config/hypr/shaders/dim.frag\" } })'";
            on-resume = "hyprctl eval 'hl.config({ decoration = { screen_shader = \"\" }, debug = { damage_tracking = 2 } })'";
          }
          {
            timeout = 480;
            on-timeout = ''hyprctl eval "hl.dsp.dpms('off')"'';
            on-resume = ''hyprctl eval "hl.dsp.dpms('on')"'';
          }
        ];
      };
    };
  };
}
