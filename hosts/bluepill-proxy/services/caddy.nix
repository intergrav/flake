{...}: {
  networking.firewall.allowedTCPPorts = [22 80 443];

  services.caddy = {
    enable = true;
    caddyfile = ''
      navidrome.devins.page {
        reverse_proxy http://100.108.47.83:4533
        encode gzip
      }
      jellyfin.devins.page {
        reverse_proxy http://100.108.47.83:8096
        encode gzip
      }
      slskd.devins.page {
        reverse_proxy http://100.108.47.83:5030
        encode gzip
      }
    '';
  };
}
