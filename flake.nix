{
  description = "qazer2687's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    sops-nix.url = "github:Mic92/sops-nix";
    nur.url = "github:nix-community/NUR";
    darwin.url = "github:lnl7/nix-darwin";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    # Fork of tpwrules/nixos-apple-silicon with performance 
    # tweaks, vulkan, louder speakers and some other things.
    #asahi.url = "github:zzywysm/nixos-asahi";
    # Pinned because things usually go wrong on updates.
    asahi.url = "github:tpwrules/nixos-apple-silicon/e8c07c3ae199b55a8c1c35a7c067c5cef9c7e929";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nixvim.url = "github:nix-community/nixvim";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    nyx.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    niri.url = "github:sodiboo/niri-flake/main";
    swww.url = "github:LGFae/swww";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{
    self,
    nixpkgs,
    home-manager,
    sops-nix,
    nur,
    darwin,
    nixvim,
    nix-homebrew,
    asahi,
    nix-vscode-extensions,
    nix-flatpak,
    nix-minecraft,
    nyx,
    niri,
    swww,
    flake-parts,
    ...
  }: 
    flake-parts.lib.mkFlake { inherit inputs; } {
      flake = {
        # Put your original flake attributes here.
      };
      systems = [
        "aarch64-linux"
        "x86_64-linux"
        "aarch64-darwin"
      ];
      perSystem = { system, config, ... }: {
      packages = import ./packages { inherit (inputs.nixpkgs.legacyPackages) system; };
      formatter = inputs.nixpkgs.legacyPackages.${system}.alejandra;

      overlays = import ./overlays { inherit inputs self; };

      nixosConfigurations = let
        sharedModules = [
          inputs.nur.modules.nixos.default
          inputs.sops-nix.nixosModules.sops
          inputs.home-manager.nixosModules.home-manager
          inputs.nixvim.homeManagerModules.nixvim
        ];
      in {
        # Jet configuration
        jet = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs self; };
          modules = [
            ./hosts/jet
            inputs.asahi.nixosModules.apple-silicon-support
            {
              home-manager = {
                users.alex = ./homes/jet;
                extraSpecialArgs = { inherit inputs self; };
                useGlobalPkgs = true;
                useUserPackages = true;
                sharedModules = sharedModules;
              };
            }
          ];
        };

        # Jade configuration
        jade = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs self; };
          modules = [
            ./hosts/jade
            inputs.nyx.nixosModules.default
            {
              home-manager = {
                users.alex = ./homes/jade;
                extraSpecialArgs = { inherit inputs self; };
                useGlobalPkgs = true;
                useUserPackages = true;
                sharedModules = sharedModules ++ [
                  inputs.nix-flatpak.homeManagerModules.nix-flatpak
                ];
              };
            }
          ];
        };

        # Amber configuration
        amber = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs self; };
          modules = [
            ./hosts/amber
          ];
        };

        # Ruby configuration
        ruby = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs self; };
          modules = [
            ./hosts/ruby
            {
              home-manager = {
                users.alex = ./homes/ruby;
                extraSpecialArgs = { inherit inputs self; };
                useGlobalPkgs = true;
                useUserPackages = true;
                sharedModules = sharedModules;
              };
            }
          ];
        };

        # Opal configuration
        opal = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs self; };
          modules = [
            ./hosts/opal
            inputs.nyx.nixosModules.default
          ];
        };
      };

      darwinConfigurations = {
        onyx = inputs.darwin.lib.darwinSystem {
          pkgs = import inputs.nixpkgs { system = "aarch64-darwin"; };
          specialArgs = { inherit inputs self; };
          modules = [
            ./hosts/onyx
            inputs.home-manager.darwinModules.home-manager
            inputs.nix-homebrew.darwinModules.nix-homebrew
            {
              home-manager = {
                users.alex = ./homes/onyx;
                extraSpecialArgs = { inherit inputs self; };
                useGlobalPkgs = true;
                useUserPackages = true;
                sharedModules = sharedModules;
              };
              nix-homebrew = {
                enable = true;
                enableRosetta = true;
                user = "alex";
                autoMigrate = true;
              };
            }
          ];
        };
      };
    };
  };
}
