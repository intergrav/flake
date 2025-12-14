{...}: {
  networking.firewall = {
    allowedTCPPorts = [23343];
    allowedUDPPorts = [22232]; # for vc
  };

  users.users.mikusmp = {
    isSystemUser = true;
    uid = 2001;
    group = "mikusmp";
  };
  users.groups.mikusmp.gid = 2001;
  users.groups.mikusmp.members = ["devin"];

  systemd.tmpfiles.rules = ["d /srv/mikusmp 2775 mikusmp mikusmp -"];

  virtualisation = {
    docker.enable = true;
    oci-containers = {
      backend = "docker";
      containers = {
        minecraft-server = {
          image = "itzg/minecraft-server:latest";
          user = "2001:2001";
          ports = [
            "23343:23343"
            "22232:22232/udp" # for vc
          ];
          volumes = [
            "/srv/mikusmp67:/data"
          ];
          environment = {
            UID = "2001";
            GID = "2001";
            EULA = "TRUE";
            TYPE = "FABRIC";
            VERSION = "1.20.1";
            MEMORY = "12G";
            DIFFICULTY = "hard";
            MOTD = "";
            ENABLE_COMMAND_BLOCK = "true";
            VIEW_DISTANCE = "4";
            SIMULATION_DISTANCE = "4";
            SEED = "61";
            SYNC_CHUNK_WRITES = "false";
            USE_AIKAR_FLAGS = "true";
            ALLOW_FLIGHT = "true";
            PACKWIZ_URL = "https://intergrav.github.io/private-modpacks/mikusmp67/pack.toml";
          };
          autoStart = true;
        };
      };
    };
  };
}
