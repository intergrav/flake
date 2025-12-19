{pkgs, ...}: {
  networking.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [25565];
    allowedUDPPorts = [25565 24454 19132];
  };

  networking.nftables = {
    enable = true;
    extraRules = ''
      table ip nat {
        chain prerouting {
          type nat hook prerouting priority dstnat; policy accept;
          tcp dport 25565 dnat to 100.109.134.42:25565;
          udp dport 25565 dnat to 100.109.134.42:25565;
          udp dport 24454 dnat to 100.109.134.42:24454;
          udp dport 19132 dnat to 100.109.134.42:19132;
        }

        chain postrouting {
          type nat hook postrouting priority srcnat; policy accept;
          ip daddr 100.109.134.42 snat to 100.108.47.83;
        }
      }
    '';
  };
}
