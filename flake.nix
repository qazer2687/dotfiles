{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    sops-nix.url = "github:Mic92/sops-nix";
    nur.url = "github:nix-community/NUR";
    darwin.url = "github:lnl7/nix-darwin/master";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    sops-nix,
    nur,
    darwin,
    nix-homebrew,
    ...
  } @ inputs: let 
    inherit (self) outputs;

    # Supported Systems
    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "aarch64-darwin"
    ];

    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # Custom Packages
    packages = forAllSystems (system: import ./packages nixpkgs.legacyPackages.${system});

    ## packages and modifications exported as overlays
    overlays = import ./overlays {inherit inputs;};

    # Formatter
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    nixosConfigurations = {
      jade = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/jade
          ./hosts/shared
          nur.nixosModules.nur
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
          {
            nix.registry.nixpkgs.flake = nixpkgs;
            nix.nixPath = ["nixpkgs=flake:nixpkgs"];

            # Home-Manager Configuration
            home-manager = {
              users.alex = ./homes/jade;
              extraSpecialArgs = {inherit inputs outputs;};
              useGlobalPkgs = true;
              useUserPackages = true;
              sharedModules = [
                inputs.nur.hmModules.nur
                inputs.sops-nix.homeManagerModules.sops
              ];
            };
          }
        ];
      };
    };

    nixosConfigurations = {
      ruby = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/ruby
          ./hosts/shared
          nur.nixosModules.nur
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
          {
            nix.registry.nixpkgs.flake = nixpkgs;
            nix.nixPath = ["nixpkgs=flake:nixpkgs"];

            # Home-Manager Configuration
            home-manager = {
              users.alex = ./homes/ruby;
              extraSpecialArgs = {inherit inputs outputs;};
              useGlobalPkgs = true;
              useUserPackages = true;
              sharedModules = [
                inputs.nur.hmModules.nur
                inputs.sops-nix.homeManagerModules.sops
              ];
            };
          }
        ];
      };
    };

    nixosConfigurations = {
      jet = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/jet
          ./hosts/shared
          nur.nixosModules.nur
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
          {
            nix.registry.nixpkgs.flake = nixpkgs;
            nix.nixPath = ["nixpkgs=flake:nixpkgs"];

            # Home-Manager Configuration
            home-manager = {
              users.alex = ./homes/jet;
              extraSpecialArgs = {inherit inputs outputs;};
              useGlobalPkgs = true;
              useUserPackages = true;
              sharedModules = [
                inputs.nur.hmModules.nur
                inputs.sops-nix.homeManagerModules.sops
              ];
            };
          }
        ];
      };
    };

    darwinConfigurations = {
      onyx = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        pkgs = import inputs.nixpkgs {system = "aarch64-darwin";};
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/onyx
          home-manager.darwinModules.home-manager
          nix-homebrew.darwinModules.nix-homebrew
          {
            # Home-Manager Configuration
            home-manager = {
              users.alex = ./homes/onyx;
              extraSpecialArgs = {inherit inputs;};
              useGlobalPkgs = true;
              useUserPackages = true;
              sharedModules = [
                inputs.nur.hmModules.nur
                inputs.sops-nix.homeManagerModules.sops
              ];
            };
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "alex";
              autoMigrate = true;
              #mutableTaps = false; # breaks declaring taps in homebrew.taps
            };
          }
        ];
      };
    };

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
        ];
      };
    };
  };
}
