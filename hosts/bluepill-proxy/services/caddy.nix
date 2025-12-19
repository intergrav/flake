{...}: {
  networking.firewall.allowedTCPPorts = [22 80 443];

  services.caddy = {
    enable = true;
    virtualHosts = {
      "navidrome.devins.page" = {
        extraConfig = ''
          encode gzip
          reverse_proxy http://100.108.47.83:4533
        '';
      };

      "jellyfin.devins.page" = {
        extraConfig = ''
          encode gzip
          reverse_proxy http://100.108.47.83:8096
        '';
      };

      "slskd.devins.page" = {
        extraConfig = ''
          encode gzip
          reverse_proxy http://100.108.47.83:5030
        '';
      };
    };
  };
}
