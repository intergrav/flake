{pkgs, ...}: {
  imports = [
    ./hardware.nix
    ./modules/caddy.nix
    ./modules/nftables.nix
  ];

  networking.hostName = "bluepill-proxy";
  networking.domain = "vps.ovh.us";

  system.autoUpgrade = {
    enable = true;
    flake = "github:intergrav/flake";
    flags = ["-L"];
    dates = "04:40";
  };
}
