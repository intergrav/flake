{lib, ...}: {
  imports = [
    ./modules/fwupd.nix
    ./modules/ssh.nix
    ./modules/tailscale.nix
  ];

  system.stateVersion = lib.mkDefault "24.11";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  zramSwap.enable = true;
  time.timeZone = lib.mkDefault "America/Nassau";
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
}
