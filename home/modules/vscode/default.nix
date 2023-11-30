{
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.vscode.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.vscode.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [
        # Theming
        pkief.material-icon-theme
        # Nix
        jnoortheen.nix-ide
        # C#
        ms-dotnettools.csharp
        # Rust
        rust-lang.rust-analyzer
        serayuzgur.crates
        # Other
        naumovs.color-highlight
        tamasfe.even-better-toml
      ];
    };
  };
}
