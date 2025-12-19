{pkgs, ...}: {
  imports = [
    ./hardware.nix
    ./services/homepage.nix
    ./services/jellyfin.nix
    ./services/mikusmp67.nix
    ./services/navidrome.nix
    ./services/newbeginnings7.nix
    ./services/restic.nix
    ./services/samba.nix
    ./services/slskd.nix
    ./services/ssh.nix
    ./services/tailscale.nix
    ./services/transmission.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "bluepill";
  networking.networkmanager.enable = true;

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
