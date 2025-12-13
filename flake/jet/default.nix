{
  inputs,
  self,
  ...
}:
inputs.nixpkgs.lib.nixosSystem {
  specialArgs = {
    inherit inputs self;
    inherit (inputs.nix-base16.outputs) base16;
  };
  modules = [
    ../../hosts/jet
    ../../modules/base/shared
    ../../modules/base/jet
    inputs.sops-nix.nixosModules.sops
    inputs.home-manager.nixosModules.home-manager
    inputs.asahi.nixosModules.apple-silicon-support
    inputs.nyx.nixosModules.default
    inputs.flatpak.nixosModules.nix-flatpak
    {
      home-manager = {
        users.alex = ../../homes/jet;
        extraSpecialArgs = {
          inherit inputs self;
          inherit (inputs.nix-base16.outputs) base16;
        };
        useGlobalPkgs = true;
        useUserPackages = true;
        sharedModules = [
          inputs.sops-nix.homeManagerModules.sops
          inputs.niri.homeModules.niri
          inputs.textfox.homeManagerModules.default
          inputs.vicinae.homeManagerModules.default
        ];
      };
    }
  ];
}
