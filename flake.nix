{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    sops-nix.url = "github:Mic92/sops-nix";

    asahi = {
      url = "github:nix-community/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nyx.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    hyprland.url = "github:hyprwm/Hyprland";

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, ...} @ inputs: {
    overlays = import ./overlays {inherit inputs;};

    nixosConfigurations = {
      # Desktop
      jade = (import ./flake/jade) {inherit inputs self;};

      # Laptop
      jet = (import ./flake/jet) {inherit inputs self;};

      # Server
      mica = (import ./flake/mica) {inherit inputs self;};
    };
  };
}
