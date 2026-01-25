{pkgs, ...}: {
  imports = [
    ./hardware.nix
    ./modules/beets.nix
    ./modules/blocky.nix
    ./modules/homepage.nix
    ./modules/immich.nix
    ./modules/jellyfin.nix
    ./modules/mikusmp67.nix
    ./modules/navidrome.nix
    ./modules/newbeginnings7.nix
    ./modules/restic.nix
    ./modules/samba.nix
    ./modules/slskd.nix
    ./modules/tangled.nix
    ./modules/transmission.nix
  ];

  networking.hostName = "bluepill";
  networking.useNetworkd = true;

  system.autoUpgrade = {
    enable = true;
    flake = "github:intergrav/flake";
    flags = ["-L"];
    dates = "04:40";
  };

  age.identityPaths = ["/etc/age.key"];
}
