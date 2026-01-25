{...}: {
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [80 443];
  };

  services.caddy = {
    enable = true;
    virtualHosts = {
      "knot.devins.page" = {
        extraConfig = ''
          reverse_proxy http://100.108.47.83:5555
        '';
      };
      "spindle.devins.page" = {
        extraConfig = ''
          reverse_proxy http://100.108.47.83:6555
        '';
      };
    };
  };
}
