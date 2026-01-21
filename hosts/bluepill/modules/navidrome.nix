{config, ...}: {
  age.secrets.navidrome = {
    file = ../../../secrets/navidrome.age;
    owner = "navidrome";
    group = "navidrome";
  };

  services.navidrome = {
    enable = true;
    openFirewall = true;
    environmentFile = config.age.secrets.navidrome.path;
    settings = {
      MusicFolder = "/srv/media/music";
      Address = "0.0.0.0";
      CoverArtPriority = "cover.*, folder.*, front.*, embedded";
    };
  };
}
