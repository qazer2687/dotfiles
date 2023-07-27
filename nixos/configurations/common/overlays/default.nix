{
  config,
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.overlays = let
    myOverlay = self: super: {
      discord = super.discord.override {
        withOpenASAR = true;
        withVencord = true;
      };
    };
  in [myOverlay];
}
