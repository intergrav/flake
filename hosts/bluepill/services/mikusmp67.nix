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

  systemd.tmpfiles.rules = ["d /srv/mikusmp67 2775 mikusmp mikusmp -"];

  virtualisation = {
    docker.enable = true;
    oci-containers = {
      backend = "docker";
      containers = {
        mikusmp67 = {
          image = "itzg/minecraft-server:latest";
          user = "2001:2001";
          ports = [
            "23343:25565"
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
            USE_MEOWICE_FLAGS = "true";
            ALLOW_FLIGHT = "true";
            ENFORCE_SECURE_PROFILE = "false";
            SPAWN_PROTECTION = "0";
            PACKWIZ_URL = "https://intergrav.github.io/private-modpacks/mikusmp67/pack.toml";
            ENABLE_AUTOPAUSE = "true";
            MAX_TICK_TIME = "-1";
          };
          autoStart = true;
        };
      };
    };
  };
}
