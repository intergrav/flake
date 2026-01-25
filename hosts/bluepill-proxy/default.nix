{pkgs, ...}: {
  imports = [
    ./hardware.nix
    ./modules/caddy.nix
    ./modules/socat.nix
  ];

  networking.hostName = "bluepill-proxy";
  networking.domain = "vps.ovh.us";
  networking.useNetworkd = true;

  system.autoUpgrade = {
    enable = true;
    flake = "github:intergrav/flake";
    flags = ["-L"];
    dates = "04:40";
  };
}
