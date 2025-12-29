{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware.nix
      ./services/fwupd.nix
      ./services/ssh.nix
      ./services/tailscale.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "devins-5495";
  networking.networkmanager.enable = true;

  system.stateVersion = "25.11";
}
