{...}: {
  imports =
    map (n: ./${n})
    (builtins.filter (n: n != "default.nix")
      (builtins.attrNames (builtins.readDir ./.)));
}
