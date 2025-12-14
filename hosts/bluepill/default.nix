{pkgs, ...}: {
  imports = [
    ./hardware.nix
    ./services/homepage.nix
    ./services/jellyfin.nix
    ./services/navidrome.nix
    ./services/restic.nix
    ./services/samba.nix
    ./services/slskd.nix
    ./services/ssh.nix
    ./services/tailscale.nix
    ./services/transmission.nix
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
