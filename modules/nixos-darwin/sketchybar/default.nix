{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.sketchybar.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.sketchybar.enable {
    services.sketchybar = {
      enable = true;
      package = pkgs.sketchybar;
      config = ''
        FONT="SF Pro" # Needs to have Regular, Bold, Semibold, Heavy and Black variants
        PADDINGS=3    # All paddings use this value (icon, label, background)

        # Setting up the general bar appearance of the bar
        bar=(
          height=45
          color="$TRANSPARENT"
          border_width=2
          border_color="$TRANSPARENT"
          shadow=off
          position=top
          sticky=on
          padding_right=10
          padding_left=10
          y_offset=0
          margin=-2
          topmost=window
        )

        sketchybar --bar "${bar[@]}"

        # Setting up default values
        defaults=(
          updates=when_shown
          icon.font="$FONT:Bold:14.0"
          icon.color="$ICON_COLOR"
          icon.padding_left="$PADDINGS"
          icon.padding_right="$PADDINGS"
          label.font="$FONT:Semibold:13.0"
          label.color="$LABEL_COLOR"
          label.padding_left="$PADDINGS"
          label.padding_right="$PADDINGS"
          padding_right="$PADDINGS"
          padding_left="$PADDINGS"
          background.height=26
          background.corner_radius=18
          background.border_width=2
          popup.background.border_width=2
          popup.background.corner_radius=9
          popup.background.border_color="$POPUP_BORDER_COLOR"
          popup.background.color="$POPUP_BACKGROUND_COLOR"
          popup.blur_radius=20
          popup.background.shadow.drawing=on
          scroll_texts=off
        )

        sketchybar --default "${defaults[@]}"
        source "$ITEM_DIR/apple.sh"
        source "$ITEM_DIR/spaces.sh"
        source "$ITEM_DIR/front_app.sh"
        source "$ITEM_DIR/yabai.sh"
        source "$ITEM_DIR/temp.sh"
        source "$ITEM_DIR/network.sh"
        source "$ITEM_DIR/ram.sh"

        # Right
        source "$ITEM_DIR/calendar.sh"
        source "$ITEM_DIR/brew.sh"
        source "$ITEM_DIR/vpn.sh"
        # source "$ITEM_DIR/github.sh"
        source "$ITEM_DIR/input_source.sh"
        source "$ITEM_DIR/wifi.sh"
        source "$ITEM_DIR/volume.sh"
        source "$ITEM_DIR/battery.sh"
        source "$ITEM_DIR/music.sh"

        sketchybar --hotload off

        # Forcing all item scripts to run (never do this outside of sketchybarrc)
        sketchybar --update
      '';
    };
  };
}
