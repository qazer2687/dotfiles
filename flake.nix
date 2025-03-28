{
  description = "qazer2687's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    sops-nix.url = "github:Mic92/sops-nix";
    nur.url = "github:nix-community/NUR";
    darwin.url = "github:lnl7/nix-darwin";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    
    #asahi.url = "github:tpwrules/nixos-apple-silicon";
    asahi.url = "github:qazer2687/nixos-apple-silicon";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nixvim.url = "github:nix-community/nixvim";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    nyx.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    niri.url = "github:sodiboo/niri-flake";
    swww.url = "github:LGFae/swww";
    flake-parts.url = "github:hercules-ci/flake-parts";
    ags.url = "github:aylur/ags";

    # Use an older version as the new version is unusable while listening to music.
    zen.url = "github:0xc000022070/zen-browser-flake/7de16ae319e6f6852274fa90b0d41c00049767c9";

    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };
  };

  outputs = inputs @ {
    self,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["aarch64-linux" "x86_64-linux" "aarch64-darwin"];

      flake = {
        overlays = import ./overlays {inherit inputs;};

        nixosConfigurations = {
          jade = inputs.nixpkgs.lib.nixosSystem {
            specialArgs = {inherit inputs self;};
            modules = [
              ./hosts/jade
              inputs.nur.modules.nixos.default
              inputs.sops-nix.nixosModules.sops
              inputs.nyx.nixosModules.default
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager = {
                  users.alex = ./homes/jade;
                  extraSpecialArgs = {inherit inputs self;};
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  sharedModules = [
                    inputs.nur.modules.homeManager.default
                    inputs.sops-nix.homeManagerModules.sops
                    inputs.nixvim.homeManagerModules.nixvim
                    inputs.nix-flatpak.homeManagerModules.nix-flatpak
                  ];
                };
              }
            ];
          };

          jet = inputs.nixpkgs.lib.nixosSystem {
            specialArgs = {inherit inputs self;};
            modules = [
              ./hosts/jet
              inputs.nur.modules.nixos.default
              inputs.sops-nix.nixosModules.sops
              inputs.home-manager.nixosModules.home-manager
              inputs.asahi.nixosModules.apple-silicon-support
              {
                home-manager = {
                  users.alex = ./homes/jet;
                  extraSpecialArgs = {inherit inputs self;};
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  sharedModules = [
                    inputs.niri.homeModules.niri
                    inputs.hyprpanel.homeManagerModules.hyprpanel
                    inputs.ags.homeManagerModules.default
                    inputs.nur.modules.homeManager.default
                    inputs.sops-nix.homeManagerModules.sops
                    inputs.nixvim.homeManagerModules.nixvim
                  ];
                };
              }
            ];
          };

          ruby = inputs.nixpkgs.lib.nixosSystem {
            specialArgs = {inherit inputs self;};
            modules = [
              ./hosts/ruby
              inputs.nur.modules.nixos.default
              inputs.sops-nix.nixosModules.sops
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager = {
                  users.alex = ./homes/ruby;
                  extraSpecialArgs = {inherit inputs;};
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  sharedModules = [
                    inputs.nur.modules.homeManager.default
                    inputs.sops-nix.homeManagerModules.sops
                    inputs.nixvim.homeManagerModules.nixvim
                  ];
                };
              }
            ];
          };

          opal = inputs.nixpkgs.lib.nixosSystem {
            specialArgs = {inherit inputs self;};
            modules = [
              ./hosts/opal
              inputs.sops-nix.nixosModules.sops
              inputs.nyx.nixosModules.default
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager = {
                  users.alex = ./homes/opal;
                  extraSpecialArgs = {inherit inputs self;};
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  sharedModules = [
                    inputs.niri.homeModules.niri
                    inputs.hyprpanel.homeManagerModules.hyprpanel
                    inputs.ags.homeManagerModules.default
                    inputs.nur.modules.homeManager.default
                    inputs.sops-nix.homeManagerModules.sops
                    inputs.nixvim.homeManagerModules.nixvim
                  ];
                };
              }
            ];
          };

          mica = inputs.nixpkgs.lib.nixosSystem {
            specialArgs = {inherit inputs self;};
            modules = [
              ./hosts/mica
              inputs.sops-nix.nixosModules.sops
              inputs.nyx.nixosModules.default
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager = {
                  users.alex = ./homes/mica;
                  extraSpecialArgs = {inherit inputs self;};
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  sharedModules = [
                    inputs.niri.homeModules.niri
                    inputs.hyprpanel.homeManagerModules.hyprpanel
                    inputs.ags.homeManagerModules.default
                    inputs.nur.modules.homeManager.default
                    inputs.sops-nix.homeManagerModules.sops
                    inputs.nixvim.homeManagerModules.nixvim
                  ];
                };
              }
            ];
          };
        };
      };
    };
}
