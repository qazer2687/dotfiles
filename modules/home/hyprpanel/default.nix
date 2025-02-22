{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.hyprpanel.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.hyprpanel.enable {
    programs.hyprpanel = {
			enable = true;

			# Automatically restart HyprPanel with systemd.
			# Useful when updating your config so that you
			# don't need to manually restart it.
			systemd.enable = true;

			# Add '/nix/store/.../hyprpanel' to your
			# Hyprland config 'exec-once'.
			hyprland.enable = true;

			# Fix the overwrite issue with HyprPanel.
			# See below for more information.
			overwrite.enable = true;

			# Import a theme from './themes/*.json'.
			theme = "gruvbox_split";

			# Override the final config with an arbitrary set.
			# Useful for overriding colors in your selected theme.
			override = {
				theme.bar.menus.text = "#123ABC";
			};

			# Configure bar layouts for monitors.
			# See 'https://hyprpanel.com/configuration/panel.html'.
			layout = {
				"bar.layouts" = {
					"0" = {
						left = [ "dashboard" "workspaces" ];
						middle = [ "media" ];
						right = [ "volume" "systray" "notifications" ];
					};
				};
			};

			# Configure and theme almost all options from the GUI.
			# Options that require '{}' or '[]' are not yet implemented,
			# except for the layout above.
			# See 'https://hyprpanel.com/configuration/settings.html'.
			settings = {
				bar.launcher.autoDetectIcon = true;
				bar.workspaces.show_icons = true;

				menus.clock = {
					time = {
						military = true;
						hideSeconds = true;
					};
					weather.unit = "metric";
				};

				menus.dashboard.directories.enabled = false;
				menus.dashboard.stats.enable_gpu = true;

				theme.bar.transparent = true;

				theme.font = {
					name = "CaskaydiaCove NF";
					size = "16px";
				};
			};
		};
  };
}
