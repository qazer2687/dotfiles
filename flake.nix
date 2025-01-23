{
  description = "qazer2687's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix.url = "github:Mic92/sops-nix";
    nur.url = "github:nix-community/NUR";
    darwin.url = "github:lnl7/nix-darwin";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    asahi.url = "github:tpwrules/nixos-apple-silicon";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nixvim.url = "github:nix-community/nixvim";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    nyx.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    niri.url = "github:sodiboo/niri-flake";
    swww.url = "github:LGFae/swww";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ { self, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "aarch64-linux" "x86_64-linux" "aarch64-darwin" ];

      flake = {
        overlays = import ./overlays { inherit inputs; };

        nixosConfigurations = {
          jet = inputs.nixpkgs.lib.nixosSystem {
            system = "aarch64-linux";
            specialArgs = { inherit inputs self; };
            modules = [
              ./hosts/jet
              inputs.nur.modules.nixos.default  # Fixed NUR module
              inputs.sops-nix.nixosModules.sops
              inputs.home-manager.nixosModules.home-manager
              inputs.asahi.nixosModules.apple-silicon-support
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.alex = {
                    imports = [
                      ./homes/jet
                      inputs.niri.homeModules.niri  # Fixed home module path
                      inputs.nur.modules.homeManager.default
                      inputs.sops-nix.homeManagerModules.sops
                      inputs.nixvim.homeManagerModules.nixvim
                      inputs.swww.homeManagerModules.default
                    ];
                  };
                };
              }
            ];
          };

          jade = inputs.nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs self; };
            modules = [
              ./hosts/jade
              inputs.nur.modules.nixos.default  # Fixed NUR module
              inputs.sops-nix.nixosModules.sops
              inputs.nyx.nixosModules.default
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.alex = {
                    imports = [
                      ./homes/jade
                      inputs.nur.modules.homeManager.default
                      inputs.sops-nix.homeManagerModules.sops
                      inputs.nixvim.homeManagerModules.nixvim
                      inputs.nix-flatpak.homeManagerModules.nix-flatpak
                      inputs.swww.homeManagerModules.default
                    ];
                  };
                };
              }
            ];
          };

          ruby = inputs.nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs self; };
            modules = [
              ./hosts/ruby
              inputs.nur.modules.nixos.default  # Fixed NUR module
              inputs.sops-nix.nixosModules.sops
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.alex = {
                    imports = [
                      ./homes/ruby
                      inputs.nur.modules.homeManager.default
                      inputs.sops-nix.homeManagerModules.sops
                      inputs.nixvim.homeManagerModules.nixvim
                      inputs.swww.homeManagerModules.default
                    ];
                  };
                };
              }
            ];
          };

          opal = inputs.nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs self; };
            modules = [
              ./hosts/opal
              inputs.sops-nix.nixosModules.sops
              inputs.nyx.nixosModules.default
              inputs.nix-minecraft.nixosModules.default
            ];
          };
        };
      };
    };
}