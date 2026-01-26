{pkgs, ...}: {
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [22 25565 23343];
    allowedUDPPorts = [25565 23343 24454 22232];
  };

  # TCP ports
  systemd.services.minecraft-tcp-25565 = {
    description = "Minecraft TCP 25565 forward";
    wants = ["network-online.target"];
    after = ["network-online.target"];
    serviceConfig = {
      ExecStart = "${pkgs.socat}/bin/socat TCP-LISTEN:25565,reuseaddr,fork TCP:100.108.47.83:25565";
      Restart = "always";
      User = "nobody";
      StandardOutput = "journal";
      StandardError = "journal";
    };
    wantedBy = ["multi-user.target"];
  };

  systemd.services.minecraft-tcp-23343 = {
    description = "Minecraft TCP 23343 forward";
    wants = ["network-online.target"];
    after = ["network-online.target"];
    serviceConfig = {
      ExecStart = "${pkgs.socat}/bin/socat TCP-LISTEN:23343,reuseaddr,fork TCP:100.108.47.83:23343";
      Restart = "always";
      User = "nobody";
      StandardOutput = "journal";
      StandardError = "journal";
    };
    wantedBy = ["multi-user.target"];
  };

  # UDP ports
  systemd.services.minecraft-udp-25565 = {
    description = "Minecraft UDP 25565 forward";
    wants = ["network-online.target"];
    after = ["network-online.target"];
    serviceConfig = {
      ExecStart = "${pkgs.socat}/bin/socat UDP-LISTEN:25565,reuseaddr,fork UDP:100.108.47.83:25565";
      Restart = "always";
      User = "nobody";
      StandardOutput = "journal";
      StandardError = "journal";
    };
    wantedBy = ["multi-user.target"];
  };

  systemd.services.minecraft-udp-24454 = {
    description = "Minecraft UDP 24454 forward";
    wants = ["network-online.target"];
    after = ["network-online.target"];
    serviceConfig = {
      ExecStart = "${pkgs.socat}/bin/socat UDP-LISTEN:24454,reuseaddr,fork UDP:100.108.47.83:24454";
      Restart = "always";
      User = "nobody";
      StandardOutput = "journal";
      StandardError = "journal";
    };
    wantedBy = ["multi-user.target"];
  };

  systemd.services.minecraft-udp-23343 = {
    description = "Minecraft UDP 23343 forward";
    wants = ["network-online.target"];
    after = ["network-online.target"];
    serviceConfig = {
      ExecStart = "${pkgs.socat}/bin/socat UDP-LISTEN:23343,reuseaddr,fork UDP:100.108.47.83:23343";
      Restart = "always";
      User = "nobody";
      StandardOutput = "journal";
      StandardError = "journal";
    };
    wantedBy = ["multi-user.target"];
  };

  systemd.services.minecraft-udp-22232 = {
    description = "Minecraft UDP 22232 forward";
    wants = ["network-online.target"];
    after = ["network-online.target"];
    serviceConfig = {
      ExecStart = "${pkgs.socat}/bin/socat UDP-LISTEN:22232,reuseaddr,fork UDP:100.108.47.83:22232";
      Restart = "always";
      User = "nobody";
      StandardOutput = "journal";
      StandardError = "journal";
    };
    wantedBy = ["multi-user.target"];
  };

  systemd.services.ssh-tcp-22 = {
    description = "SSH TCP 22 forward";
    wants = ["network-online.target"];
    after = ["network-online.target"];
    serviceConfig = {
      ExecStart = "${pkgs.socat}/bin/socat TCP-LISTEN:22,reuseaddr,fork TCP:100.108.47.83:22";
      Restart = "always";
      User = "nobody";
      StandardOutput = "journal";
      StandardError = "journal";
    };
    wantedBy = ["multi-user.target"];
  };
}
