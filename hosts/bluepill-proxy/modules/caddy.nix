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
          reverse_proxy http://100.108.47.83:5555 {
            header_up Host {http.request.host}
            header_up X-Real-IP {http.request.remote}
            header_up X-Forwarded-For {http.request.remote}
            header_up X-Forwarded-Proto {http.request.scheme}
          }
        '';
      };
      "spindle.devins.page" = {
        extraConfig = ''
          reverse_proxy http://100.108.47.83:6555 {
            header_up Host {http.request.host}
            header_up X-Real-IP {http.request.remote}
            header_up X-Forwarded-For {http.request.remote}
            header_up X-Forwarded-Proto {http.request.scheme}
          }
        '';
      };
    };
  };
}
