{...}: {
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

  systemd.services.enable-gro = {
    description = "enable gro on ens6";
    after = ["network.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/sbin/ethtool -K ens6 gro on";
    };
    wantedBy = ["multi-user.target"];
  };

  services.tailscale.enable = true;
}
