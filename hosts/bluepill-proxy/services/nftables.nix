{pkgs, ...}: {
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [22 25565];
    allowedUDPPorts = [25565 24454 19132];
  };

  networking.nat = {
    enable = true;
    externalInterface = "ens6";
    externalIP = "100.108.47.83";
    forwardPorts = [
      {
        sourcePort = 25565;
        proto = "tcp";
        destination = "100.109.134.42:25565";
      }
      {
        sourcePort = 25565;
        proto = "udp";
        destination = "100.109.134.42:25565";
      }
      {
        sourcePort = 24454;
        proto = "udp";
        destination = "100.109.134.42:24454";
      }
      {
        sourcePort = 19132;
        proto = "udp";
        destination = "100.109.134.42:19132";
      }
    ];
  };
}
