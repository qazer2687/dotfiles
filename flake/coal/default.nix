{
  inputs,
  self,
  ...
}: let
  shared = ../../modules/base/shared;
  exclude = ["flatpak"];
  modules = builtins.filter (n: n != "default.nix" && !builtins.elem n exclude)
    (builtins.attrNames (builtins.readDir shared));
in
inputs.nixpkgs.lib.nixosSystem {
  specialArgs = {
    inherit inputs self;
    inherit (inputs.nix-base16.outputs) base16;
  };
  modules = [
    ../../hosts/coal
    {
      imports = map (n: "${shared}/${n}") modules;
    }
    ../../modules/base/coal
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480
    inputs.sops-nix.nixosModules.sops
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
