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
    ../../hosts/coal
    ../../modules/base/shared
    ../../modules/base/coal
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480
    inputs.sops-nix.nixosModules.sops
    inputs.flatpak.nixosModules.nix-flatpak
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        users.alex = ../../homes/coal;
        extraSpecialArgs = {
          inherit inputs self;
          inherit (inputs.nix-base16.outputs) base16;
        };
        useGlobalPkgs = true;
        useUserPackages = true;
        sharedModules = [
          inputs.sops-nix.homeManagerModules.sops
        ];
      };
    }
  ];
}
