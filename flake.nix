{
  inputs = {
    # Unable to play videos on firefox with latest.
    nixpkgs.url = "github:NixOS/nixpkgs/8a6d5427d99ec71c64f0b93d45778c889005d9c2";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    asahi.url = "github:nix-community/nixos-apple-silicon/b99bf9bf7445416fe55da09034fc4a6cd733805c";

    nyx.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    sops-nix.url = "github:Mic92/sops-nix";
    flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    textfox.url = "github:adriankarlen/textfox";

    vicinae.url = "github:vicinaehq/vicinae/v0.15.7";

    hyprland = {
      url = "github:hyprwm/Hyprland";
      #inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Personal
    nix-base16.url = "github:qazer2687/nix-base16";
  };

  outputs = {self, ...} @ inputs: {
    overlays = import ./overlays {inherit inputs;};

    nixosConfigurations = {
      # Desktop
      sage = (import ./flake/sage) {inherit inputs self;};

      # Laptop
      jet = (import ./flake/jet) {inherit inputs self;};

      # Server
      mica = (import ./flake/mica) {inherit inputs self;};
    };
  };
}
