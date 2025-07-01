{config, ...}: {
  imports = [
    ./shared
    ./${config.networking.hostName}
  ];
}
