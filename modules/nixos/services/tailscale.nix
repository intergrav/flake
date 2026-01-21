{pkgs, ...}: {
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
    openFirewall = true;
  };

  services.networkd-dispatcher = {
    enable = true;
    rules."50-tailscale-optimizations" = {
      onState = ["routable"];
      script = ''
        ${pkgs.ethtool}/bin/ethtool -K eth0 rx-udp-gro-forwarding on rx-gro-list off
      '';
    };
  };
}
