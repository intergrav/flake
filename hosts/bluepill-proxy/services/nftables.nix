{
  networking = {
    sysctl = {
      "net.ipv4.ip_forward" = 1;
      "net.ipv6.conf.all.forwarding" = 1;
    };

    firewall = {
      enable = true;
      allowedTCPPorts = [25565];
      allowedUDPPorts = [25565 24454 19132];

      extraCommands = ''
        nft add rule ip nat postrouting oif tailscale0 ip daddr 100.109.134.42 counter snat to 100.108.47.83
      '';
    };

    nat = {
      enable = true;
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
  };
}
