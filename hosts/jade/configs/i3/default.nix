{config, pkgs, ...}:

{
  home-manager.users.alex.xdg.configFile."i3/config".text = ''
  set $mod Mod4
  exec --no-startup-id dex --autostart --environment i3
  bindsym $mod+Return exec alacritty
  bindsym $mod+space floating toggle
  bindsym $mod+q kill
  bindsym $mod+e exec --no-startup-id dmenu_run -i -nb "#111111" -sb "#ffffff" -nf "#ffffff" -sf "#000000" -fn "FiraCode Nerd Font"
  exec_always --no-startup-id feh --bg-fill $HOME/.config/feh/wallpaper.png
  exec_always --no-startup-id $HOME/.config/polybar/launch.sh &
  bindsym $mod+Left move left
  bindsym $mod+Down move down
  bindsym $mod+Up move up
  bindsym $mod+Right move right
  bindsym $mod+Shift+Right resize shrink width 5 px or 5 ppt
  bindsym $mod+Shift+Up resize grow height 5 px or 5 ppt
  bindsym $mod+Shift+Down resize shrink height 5 px or 5 ppt
  bindsym $mod+Shift+Left resize grow width 5 px or 5 ppt
  bindsym $mod+1 workspace number 1
  bindsym $mod+2 workspace number 2
  bindsym $mod+3 workspace number 3
  bindsym $mod+4 workspace number 4
  bindsym $mod+5 workspace number 5
  bindsym $mod+6 workspace number 6
  bindsym $mod+7 workspace number 7
  bindsym $mod+8 workspace number 8
  bindsym $mod+9 workspace number 9
  bindsym $mod+0 workspace number 10
  bindsym $mod+Shift+1 move container to workspace number 1
  bindsym $mod+Shift+2 move container to workspace number 2
  bindsym $mod+Shift+3 move container to workspace number 3
  bindsym $mod+Shift+4 move container to workspace number 4
  bindsym $mod+Shift+5 move container to workspace number 5
  bindsym $mod+Shift+6 move container to workspace number 6
  bindsym $mod+Shift+7 move container to workspace number 7
  bindsym $mod+Shift+8 move container to workspace number 8
  bindsym $mod+Shift+9 move container to workspace number 9
  bindsym $mod+Shift+0 move container to workspace number 10
  bindsym $mod+Shift+r restart
  default_border pixel 0
  gaps inner 5
  gaps outer 0
  border_radius 5
  bar {
          mode invisible
  }
  '';
}
