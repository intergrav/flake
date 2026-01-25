{pkgs, ...}: {
  imports = [
    ./hardware.nix
  ];

  networking.hostName = "bluepill-proxy";
  networking.domain = "vps-6ad86777.vps.ovh.us";

  users.users.root.openssh.authorizedKeys.keys = [''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILyOJLlmq653uVs/1KdVnaMzi+EolB7EJMJ7AdBxVi6m devin@devins.page''];
  users.users.devin.openssh.authorizedKeys.keys = [''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILyOJLlmq653uVs/1KdVnaMzi+EolB7EJMJ7AdBxVi6m devin@devins.page''];

  system.autoUpgrade = {
    enable = true;
    flake = "github:intergrav/flake";
    flags = ["-L"];
    dates = "04:40";
  };
}
