{...}: {
  imports = 
    let
      modules = builtins.readDir ./.;
    in
      map (name: ./. + "/${name}") 
        (builtins.filter 
          (name: name != "default.nix" && name != "_archived") 
          (builtins.attrNames modules));
}