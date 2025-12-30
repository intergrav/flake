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

  environment.systemPackages = with pkgs; [
    steam
    prismlauncher
    chromium
    (discord.override {
      withOpenASAR = true;
      withMoonlight = true;
    })
    rewaita
    adw-gtk3
    refine
  ];

  programs.chromium = {
    enable = true;
    extensions = [
      "clngdbkpkpeebahjckkjfobafhncgmne"
      "ddkjiahejlhfcafbddmgiahcphecmpfh"
    ];
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  system.stateVersion = "25.11";
}
