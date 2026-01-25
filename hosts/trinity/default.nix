{pkgs, ...}: {
  imports = [
    ./hardware.nix
    ./modules/tlp.nix
  ];

  networking.hostName = "trinity";
  networking.networkmanager.enable = true;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    gnome-software
    refine
    adw-gtk3
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.paperwm
    gnomeExtensions.rounded-corners
    gnomeExtensions.rounded-window-corners-reborn
    gnomeExtensions.user-themes

    vscode-fhs
  ];

  system.stateVersion = "25.11";
}
