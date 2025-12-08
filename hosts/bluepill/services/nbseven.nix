{...}: {
  networking.firewall = {
    allowedTCPPorts = [25565];
    allowedUDPPorts = [24454]; # for vc
  };

  virtualisation = {
    docker.enable = true;
    oci-containers = {
      backend = "docker";
      containers = {
        minecraft-server = {
          image = "itzg/minecraft-server:latest";
          ports = [
            "25565:25565"
            "24454:24454/udp" # for vc
          ];
          volumes = [
            "/srv/nbseven:/data"
          ];
          environment = {
            EULA = "TRUE";
            TYPE = "FABRIC";
            VERSION = "1.21.7";
            MEMORY = "12G";
            DIFFICULTY = "hard";
            MOTD = "welcoem to NEW BEGINNINGS SERVER 7";
            ENABLE_COMMAND_BLOCK = "true";
            VIEW_DISTANCE = "12";
            SIMULATION_DISTANCE = "6";
            SEED = "-8024242352340898148";
            SYNC_CHUNK_WRITES = "false";
            USE_AIKAR_FLAGS = "true";
            ALLOW_FLIGHT = "true";
            PACKWIZ_URL = "https://intergrav.github.io/private-modpacks/nb7/pack.toml";
            VANILLATWEAKS_SHARECODE = "KHhik4, DjYDGd";
          };
          autoStart = true;
        };
      };
    };
  };

  system.activationScripts.minecraft.text = ''
    mkdir -p /srv/nbseven
    chown -R 1000:1000 /srv/nbseven
    chmod -R 775 /srv/nbseven
  '';
}
