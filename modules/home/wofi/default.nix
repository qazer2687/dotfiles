{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.wofi.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.wofi.enable {
    programs.wofi = {
      enable = true;
      settings = {
        mode = "drun";
        prompt = "";
        
      };
      style = ''
        * {
          all: unset;
          font-family: "FiraCode Nerd Font";
          font-size: 14px;
        }

        #window {
          background-color: #000000;
          border-radius: 5px;
        }

        #input{
          margin: 1rem;
          padding: 0.5rem;
          border-radius: 5px;
          background-color: #262626;
        }

        #entry {
          margin: 0.25rem 0.75rem 0.25rem 0.75rem;
          padding: 0.25rem 0.75rem 0.25rem 0.75rem;
          color: #9699b7;
          border-radius: 8px;
        }

        #entry:selected {
          background-color: #ffffff;
          color: #000000;
        }
      '';
    };
  };
}
