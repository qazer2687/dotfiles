{
  lib,
  config,
  ...
}: {
  options.modules.wofi.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.wofi.enable {
    programs.wofi = {
      enable = true;
      settings = {
        mode = "drun";
        prompt = "";
        allow_images = "false";
        insensitive = "true";
        no_actions = "true";
        hide_scroll = "true";
        allow_markup = "false";
        matching = "multi-contains";
        dynamic_lines = "true";
      };
      style = ''
        * {
          all: unset;
          font-family: "Departure Mono";
          font-size: 11px;
        }

        #window {
          background-color: #000000;
          border-radius: 4px;
        }

        #input{
          margin: 4px;
          padding: 0.5rem;
          border-radius: 4px;
          background-color:rgb(255, 255, 255);
          color:rgb(0, 0, 0);
        }

        #entry {
          margin-left: 4px;
          margin-right: 4px;
          padding: 4px;
          color: #ffffff;
          border-radius: 4px;
        }

        #entry:selected {
          background-color: #ffffff;
          color: #000000;
        }

        #input:first-child > :nth-child(1) {
          padding: -50px;
          margin: -50px;
          color: transparent;
          background-color = transparent;
        }
      '';
    };
  };
}
