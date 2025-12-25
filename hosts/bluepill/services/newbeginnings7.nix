{...}: {
  networking.firewall = {
    allowedTCPPorts = [25565];
    allowedUDPPorts = [
      24454 # for vc
      19132 # for geyser
    ];
  };

  users.users.newbeginnings = {
    isSystemUser = true;
    uid = 2002;
    group = "newbeginnings";
  };
  users.groups.newbeginnings.gid = 2002;
  users.groups.newbeginnings.members = ["devin"];

  systemd.tmpfiles.rules = ["d /srv/newbeginnings7 2775 newbeginnings newbeginnings -"];

  virtualisation = {
    docker.enable = true;
    oci-containers = {
      backend = "docker";
      containers = {
        newbeginnings7 = {
          image = "itzg/minecraft-server:latest";
          user = "2002:2002";
          ports = [
            "25565:25565"
            "24454:24454/udp" # for vc
            "19132:19132/udp" # for geyser
          ];
          volumes = [
            "/srv/newbeginnings7:/data"
          ];
          environment = {
            UID = "2002";
            GID = "2002";
            EULA = "TRUE";
            TYPE = "FABRIC";
            VERSION = "1.21.10";
            MEMORY = "12G";
            DIFFICULTY = "hard";
            MOTD = "";
            ENABLE_COMMAND_BLOCK = "true";
            VIEW_DISTANCE = "10";
            SIMULATION_DISTANCE = "5";
            SEED = "-8024242352340898148";
            SYNC_CHUNK_WRITES = "false";
            USE_MEOWICE_FLAGS = "true";
            ALLOW_FLIGHT = "true";
            ENFORCE_SECURE_PROFILE = "false";
            SPAWN_PROTECTION = "0";
            PACKWIZ_URL = "https://intergrav.github.io/private-modpacks/newbeginnings7/pack.toml";
          };
          autoStart = true;
        };
      };
    };
  };
}
