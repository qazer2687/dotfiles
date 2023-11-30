{
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.code.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.code.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode-fhs;
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
        dustypomerleau.rust-syntax
        # Other
        naumovs.color-highlight
        tamasfe.even-better-toml
      ];
    };
  };
}
