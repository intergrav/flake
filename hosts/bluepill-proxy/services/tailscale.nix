{...}: {
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

  networking.interfaces.ens6.ethtool.gro = true;

  services.tailscale.enable = true;
}
