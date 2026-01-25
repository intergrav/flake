{...}: {
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [80 443];
  };

  services.caddy = {
    enable = true;
    package = pkgs.caddy.withPlugins {
      plugins = [
        "github.com/mholt/caddy-l4"
      ];
    };
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
    };
  };
}
