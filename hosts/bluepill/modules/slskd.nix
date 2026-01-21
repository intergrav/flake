{...}: {
  networking.firewall.allowedTCPPorts = [5030];

  age.secrets.slskd = {
    file = ../../../secrets/slskd.age;
    owner = "slskd";
    group = "slskd";
  };

  services.slskd = {
    enable = true;
    openFirewall = true;
    domain = null;
    environmentFile = config.age.secrets.slskd.path;
    settings = {
      shares.directories = ["/srv/media/music"];
      soulseek.description = "\n- running on NixOS and slskd\n- all files are compressed from FLAC/WAV to AAC with `fdk-aac -vbr 5` (essentially the best and most transparent AAC you can possibly get)\n- tagged and organized with beets\n\nthey/he | feel free to say hi, i don't check my messages super often though. enjoy the shares, and remember to try and support artists if you can :)";
    };
  };

  systemd.tmpfiles.rules = [
    "Z /var/lib/slskd 0775 slskd slskd -"
  ];

  users.groups.slskd.members = ["devin"];
}
