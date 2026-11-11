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
        fragColor = vec4(pow(c.rgb, vec3(2.0)) * 0.7, c.a);
      }
    '';

    services.hypridle = {
      enable = true;
      settings = {
        listener = [
          {
            timeout = 240;
            on-timeout = ''hyprctl eval ''hl.config({ decoration = { screen_shader = "/home/alex/.config/hypr/shaders/dim.frag" } })'';'';
            on-resume = ''hyprctl eval ''hl.config({ decoration = { screen_shader = "" } })'';'';
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
