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
    ../../hosts/sage
    ../../modules/base/shared
    ../../modules/base/sage
    inputs.sops-nix.nixosModules.sops
    inputs.home-manager.nixosModules.home-manager
    inputs.nyx.nixosModules.default
    inputs.flatpak.nixosModules.nix-flatpak
    {
      home-manager = {
        users.alex = ../../homes/sage;
        extraSpecialArgs = {
          inherit inputs self;
          inherit (inputs.nix-base16.outputs) base16;
        };
        useGlobalPkgs = true;
        useUserPackages = true;
        sharedModules = [
          inputs.niri.homeModules.niri
          inputs.sops-nix.homeManagerModules.sops
          inputs.vicinae.homeManagerModules.default
        ];
      };
    }
  ];
}
