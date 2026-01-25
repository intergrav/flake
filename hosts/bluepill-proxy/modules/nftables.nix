{...}: {
  networking.firewall = {
    networking.firewall.allowedTCPPorts = [25565 23343];
    networking.firewall.allowedUDPPorts = [25565 23343 24454 22232];
  };

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
  };

  networking.nftables = {
    enable = true;
    ruleset = ''
      table ip nat {
        chain prerouting {
          type nat hook prerouting priority 0;

          tcp dport 25565 dnat to 100.108.47.83:25565
          udp dport 25565 dnat to 100.108.47.83:25565
          udp dport 24454 dnat to 100.108.47.83:24454

          tcp dport 23343 dnat to 100.108.47.83:23343
          udp dport 23343 dnat to 100.108.47.83:23343
          udp dport 22232 dnat to 100.108.47.83:22232
        }
      }

      table ip filter {
        chain forward {
          type filter hook forward priority 0;
          policy accept;
        }
      }
    '';
  };
}
