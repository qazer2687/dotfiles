{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  
  imports = [
    # Programs
    ./programs/bash
    ./programs/direnv
    ./programs/git
    ./programs/mpd
    ./programs/nvim
    ./programs/udiskie

    # Services

  ];
}
