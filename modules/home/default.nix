{...}: {
  imports = 
    let
      modules = builtins.readDir ./.;
    in
      map (name: ./. + "/${name}") 
        (builtins.filter 
          (name: name != "default.nix") 
          (builtins.attrNames modules));
}