{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.starship.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.starship.enable {
    programs.starship = {
      enable = true;
      enableFishIntegration = true;
      enableTransience = true;
      settings = {
        add_newline = false;

        format = "$directory$character";
        right_format = "$status$cmd_duration$git_branch${custom.git_status_dirty}$git_status";

        character = {
          success_symbol = "[>](green)";
          error_symbol = "[>](red)";
          vicmd_symbol = "[<](purple)";
        };

        directory = {
          style = "blue";
          truncation_length = 1;
          truncation_symbol = "";
          fish_style_pwd_dir_length = 1;
        };

        git_branch = {
          format = " [\$branch](\$style)";
          style = "green";
        };

        git_status = {
          format = "( [\\[\$ahead_behind\$stashed]](\$style))";
          style = "cyan";
          stashed = "≡";
          ahead = "⇡\${count}";
          behind = "⇣\${count}";
        };

        custom.git_status_dirty = {
          when = "test -n ''$(git status --porcelain 2>/dev/null)";
          symbol = "•";
          style = "white";
          format = "[\$symbol](\$style)";
          shell = ["sh"];
        };

        cmd_duration = {
          format = " [\$duration](\$style)";
        };

        line_break = {
          disabled = true;
        };

        status = {
          disabled = false;
          symbol = " ✘";
        };
      };
    };
  };
}
