{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.vscode.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.vscode.enable {
    programs.vscode = {
      enable = true;
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      package = pkgs.vscodium-fhs;
      extensions = with pkgs.vscode-extensions; [
        # UI Theme
        jdinhlife.gruvbox

        # Icon Theme
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
        mkhl.direnv

      ];
    };
  };
}
