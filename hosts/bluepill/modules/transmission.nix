{pkgs, ...}: {
  age.secrets.transmission = {
    file = ../../../secrets/transmission.age;
    owner = "transmission";
    group = "transmission";
  };

  services.transmission = {
    enable = true;
    openRPCPort = true;
    openPeerPorts = true;
    package = pkgs.transmission_4;
    credentialsFile = config.age.secrets.transmission.path;
    settings = {
      incomplete-dir-enabled = false;
      umask = "000";
      rpc-bind-address = "0.0.0.0";
      rpc-whitelist-enabled = false;
      rpc-authentication-required = true;
      rpc-username = "devin";
      performanceNetParameters = true;
    };
  };

  systemd.tmpfiles.rules = [
    "Z /var/lib/transmission 0770 transmission transmission -"
  ];

  users.groups.transmission.members = ["devin"];
}
