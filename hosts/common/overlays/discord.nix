{ config, pkgs, inputs, ... }: {
  nixpkgs.overlays =
    let
      overlay = self: super: {
        discord = super.discord.override { withOpenASAR = true; withVencord = true; };
      };
    in
    [ overlay ];
}
