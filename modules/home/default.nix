{osConfig, ...}: {
  imports = [
    ./shared
    ./${osConfig.networking.hostName}
  ];
}
