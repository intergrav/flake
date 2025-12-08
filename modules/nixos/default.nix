{lib, ...}: {
  system.stateVersion = lib.mkDefault "24.11";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.networkmanager.enable = true;
  zramSwap.enable = true;
  time.timeZone = lib.mkDefault "America/Nassau";
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
}
