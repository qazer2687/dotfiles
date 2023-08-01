{
  description = "Qazer's NixOS Configuration";

  inputs = {
    # Unstable Packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Custom NUR
    nur.url = "https://github.com/***REMOVED***/nur-combined";
    nur.flake = false;

    # Home-Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Sops-Nix
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    # Spicetify-Nix
    spicetify-nix.url = "github:the-argus/spicetify-nix";
  };

  outputs = {
    nixpkgs,
    home-manager,
    sops-nix,
    nur,
    ...
  } @ inputs: {
    # Hosts
    nixosConfigurations = {
      # Desktop Configuration
      jade = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./nixos/configurations/jade
          sops-nix.nixosModules.sops
          {
            nix.registry.nixpkgs.flake = nixpkgs;
            nix.nixPath = ["nixpkgs=flake:nixpkgs"];
          }
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              users.alex = ./home/configurations/jade;
              extraSpecialArgs = {inherit inputs;};
              useGlobalPkgs = true;
              useUserPackages = true;
              sharedModules = [inputs.sops-nix.homeManagerModules.sops];
            };
          }
        ];
      };

      # Laptop Configuration
      ruby = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./nixos/configurations/ruby
          sops-nix.nixosModules.sops
          {
            nix.registry.nixpkgs.flake = nixpkgs;
            nix.nixPath = ["nixpkgs=flake:nixpkgs"];
          }
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              users.alex = ./home/configurations/ruby;
              useGlobalPkgs = true;
              useUserPackages = true;
              sharedModules = [<sops-nix/modules/home-manager/sops.nix>];
            };
          }
        ];
      };
    };
  };
}
