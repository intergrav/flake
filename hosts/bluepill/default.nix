{pkgs, ...}: {
  imports = [
    ./hardware.nix
    ./services/homepage.nix
    ./services/jellyfin.nix
    ./services/navidrome.nix
    ./services/restic.nix
    ./services/samba.nix
    ./services/slskd.nix
    ./services/ssh.nix
    ./services/tailscale.nix
    ./services/transmission.nix
  ];

  networking.hostName = "bluepill";
  environment.systemPackages = with pkgs; [
    age
    beets
    (ffmpeg.override {
      withFdkAac = true;
      withUnfree = true;
    })
    imagemagick
    restic
  ];
  age.identityPaths = ["/etc/age.key"];

  users.groups.share-general.members = ["transmission" "devin"];
  system.activationScripts.generalShare.text = ''
    mkdir -p /srv/general
    chown -R root:share-general /srv/general
    chmod -R 775 /srv/general
  '';

  users.groups.share-media.members = ["jellyfin" "navidrome" "slskd" "transmission" "devin"];
  system.activationScripts.mediaShare.text = ''
    mkdir -p /srv/media
    chown -R root:share-media /srv/media
    chmod -R 775 /srv/media
  '';
}
