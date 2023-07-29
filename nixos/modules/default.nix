{...}: {
  imports = [
    # Audio
    ./audio/pipewire

    # Boot
    ./boot/silentboot
    ./boot/stage2patch
    ./boot/loader

    # Desktop
    ./desktop/gdm
    ./desktop/i3

    # Gaming
    ./gaming/steam

    # Misc
    ./misc/colemak
    ./misc/fonts
    ./misc/mouseaccel
    ./misc/tlp
    ./misc/zram

    # Security
    ./security/keepassxc
    ./security/gnome-keyring

    # Network
    ./network/networkmanager

    # System
    ./system/udev/via
    ./system/kernel

    # Video
    ./video/nvidia
  ];
}
