{pkgs, ...}: {
  networking.firewall = {
    allowedTCPPorts = [80 443];
  };

  services.caddy = {
    enable = true;
    email = "devin@devins.page";
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
      "navidrome.devins.page" = {
        extraConfig = ''
          reverse_proxy http://100.108.47.83:4533
        '';
      };
      "jellyfin.devins.page" = {
        extraConfig = ''
          reverse_proxy http://100.108.47.83:8096
        '';
      };
    };
  };
}
