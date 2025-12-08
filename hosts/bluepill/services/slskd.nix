{...}: {
  networking.firewall.allowedTCPPorts = [5030];

  age.secrets.slskd = {
    file = ../../../secrets/slskd.age;
    owner = "slskd";
    group = "slskd";
    path = "/etc/secrets/slskd";
  };

  services.slskd = {
    enable = true;
    openFirewall = true;
    domain = null;
    environmentFile = "/etc/secrets/slskd";
    settings = {
      shares.directories = ["/srv/media/music"];
      soulseek.description = "\n- running on NixOS and slskd\n- all files are compressed from FLAC/WAV to AAC with `fdk-aac -vbr 5` (essentially the best and most transparent AAC you can possibly get)\n- tagged and organized with beets\n\nthey/he | feel free to say hi, i don't check my messages super often though. enjoy the shares, and remember to try and support artists if you can :)";
    };
  };
  
  users.groups.slskd.members = ["devin"]; 
}
