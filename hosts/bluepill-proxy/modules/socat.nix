{pkgs, ...}: {
  networking.firewall = {
    allowedTCPPorts = [25565 23343];
    allowedUDPPorts = [25565 23343 24454 22232];
  };

  systemd.services.minecraft-forward = {
    description = "Minecraft TCP+UDP forward";
    wants = ["network-online.target"];
    after = ["network-online.target"];
    serviceConfig = {
      ExecStart = ''
        ${pkgs.socat}/bin/socat TCP-LISTEN:25565,reuseaddr,fork TCP:100.108.47.83:25565 &
        ${pkgs.socat}/bin/socat UDP-LISTEN:25565,reuseaddr,fork UDP:100.108.47.83:25565 &
        ${pkgs.socat}/bin/socat UDP-LISTEN:24454,reuseaddr,fork UDP:100.108.47.83:24454 &

        ${pkgs.socat}/bin/socat TCP-LISTEN:23343,reuseaddr,fork TCP:100.108.47.83:23343 &
        ${pkgs.socat}/bin/socat UDP-LISTEN:23343,reuseaddr,fork UDP:100.108.47.83:23343 &
        ${pkgs.socat}/bin/socat UDP-LISTEN:22232,reuseaddr,fork UDP:100.108.47.83:22232 &
        wait
      '';
      Restart = "always";
      User = "nobody";
      StandardOutput = "journal";
      StandardError = "journal";
    };
    wantedBy = ["multi-user.target"];
  };
}
