{inputs, ...}: {
  additions = final: _prev: import ../packages final.pkgs;
  modifications = final: prev: {
  };
}