{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware.nix
    ./services/power.nix
    ./services/fwupd.nix
    ./services/ssh.nix
    ./services/tailscale.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "trinity";
  networking.networkmanager.enable = true;

  powerManagement.enable = true;

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    gnome-software
    refine
    adw-gtk3
    gnomeExtensions.blur-my-shell
    gnomeExtensions.paperwm
    gnomeExtensions.user-themes

    steam # flatpak has issues, using nixpkg
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  system.stateVersion = "25.11";
}
