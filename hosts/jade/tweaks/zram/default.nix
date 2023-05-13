{ config, pkgs, inputs, ... }:
{
  # ZRam
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 20;
  };
}