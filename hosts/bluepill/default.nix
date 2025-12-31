{pkgs, ...}: {
  imports = [
    ./hardware.nix
    ../../modules/nixos/services/homepage.nix
    ../../modules/nixos/services/jellyfin.nix
    ../../modules/nixos/services/mikusmp67.nix
    ../../modules/nixos/services/navidrome.nix
    ../../modules/nixos/services/newbeginnings7.nix
    ../../modules/nixos/services/restic.nix
    ../../modules/nixos/services/samba.nix
    ../../modules/nixos/services/slskd.nix
    ../../modules/nixos/services/transmission.nix
  ];

  networking.hostName = "bluepill";

  environment.systemPackages = with pkgs; [
    age
    beets
    (ffmpeg.override {
      withFdkAac = true;
      withUnfree = true;
    })
    imagemagick
    restic
  ];

  system.autoUpgrade = {
    enable = true;
    flake = "github:intergrav/flake";
    flags = ["-L"];
    dates = "04:40";
  };

  age.identityPaths = ["/etc/age.key"];
}
