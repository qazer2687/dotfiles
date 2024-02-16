{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    sops-nix.url = "github:Mic92/sops-nix";
    simple-nixos-mailserver.url = "gitlab:simple-nixos-mailserver/nixos-mailserver/nixos-23.11";
  };

  outputs = {
    nixpkgs,
    home-manager,
    sops-nix,
    simple-nixos-mailserver,
    ...
  } @ inputs: {

    # Desktop Configuration
    nixosConfigurations = {
      jade = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/jade
          ./hosts/shared
          {
            nix.registry.nixpkgs.flake = nixpkgs;
            nix.nixPath = ["nixpkgs=flake:nixpkgs"];
          }
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              users.alex = ./homes/alex-jade;
              extraSpecialArgs = {inherit inputs;};
              useGlobalPkgs = true;
              useUserPackages = true;
              sharedModules = [
                inputs.sops-nix.homeManagerModules.sops
              ];
            };
          }
        ];
      };
    };

    # Laptop Configuration
    nixosConfigurations = {
      ruby = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/ruby
          ./hosts/shared
          {
            nix.registry.nixpkgs.flake = nixpkgs;
            nix.nixPath = ["nixpkgs=flake:nixpkgs"];
          }
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              users.alex = ./homes/alex-ruby;
              extraSpecialArgs = {inherit inputs;};
              useGlobalPkgs = true;
              useUserPackages = true;
              sharedModules = [
                inputs.sops-nix.homeManagerModules.sops
              ];
            };
          }
        ];
      };
    };

    # Server Configuration
    nixosConfigurations = {
      opal = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/opal
          ./hosts/shared
          {
            nix.registry.nixpkgs.flake = nixpkgs;
            nix.nixPath = ["nixpkgs=flake:nixpkgs"];
          }
          sops-nix.nixosModules.sops
          simple-nixos-mailserver.nixosModule
        ];
      };
    };
  };
}
