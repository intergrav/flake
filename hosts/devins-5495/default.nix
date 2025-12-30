{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware.nix
    ./services/fwupd.nix
    ./services/ssh.nix
    ./services/tailscale.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "devins-5495";
  networking.networkmanager.enable = true;

  services.displayManager.gdm.enable = true;
  programs.niri.enable = true;
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.swaylock = {};
  programs.waybar.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    firefox
    (discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
    prismlauncher
    alacritty
    fuzzel
    swaylock
    mako
    swayidle
  ];

  system.stateVersion = "25.11";
}
