{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    asahi.url = "github:nix-community/nixos-apple-silicon";
    sops-nix.url = "github:Mic92/sops-nix";
    flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    hyprland.url = "github:hyprwm/Hyprland";
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    # Personal
    nix-base16.url = "github:qazer2687/nix-base16";
  };

  outputs = {self, ...} @ inputs: {
    overlays = import ./overlays {inherit inputs;};

    nixosConfigurations = {
      # Desktop
      sage = (import ./flake/sage) {inherit inputs self;};

      # Primary Laptop
      jet = (import ./flake/jet) {inherit inputs self;};

      # Secondary Laptop
      ivy = (import ./flake/ivy) {inherit inputs self;};
    };
  };
}
