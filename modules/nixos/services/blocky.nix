{...}: {
  networking.firewall = {
    allowedTCPPorts = [53];
    allowedUDPPorts = [53];
  };

  services.blocky = {
    enable = true;
    settings = {
      ports.dns = 53;
      upstreams.groups.default = [
        "https://one.one.one.one/dns-query"
      ];
      blocking = {
        denylists = {
          ads = [
            "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/wildcard/pro.txt"
          ];
        };
        clientGroupsBlock = {
          default = [
            "ads"
          ];
        };
      };
      caching = {
        minTime = "5m";
        maxTime = "30m";
        prefetching = true;
      };
    };
  };
}
