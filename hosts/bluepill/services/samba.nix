{...}: {
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      workstation = true;
      userServices = true;
      hinfo = true;
    };
  };

  services.avahi.extraServiceFiles = [
    (pkgs.writeText "device-info.service" ''
      <?xml version="1.0" standalone='no'?>
      <!DOCTYPE service-group SYSTEM "avahi-service.dtd">
      <service-group>
        <name replace-wildcards="yes">%h</name>
        <service>
          <type>_device-info._tcp</type>
          <port>0</port>
          <txt-record>model=RackMac</txt-record>
        </service>
      </service-group>
    '')
  ];

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        # https://wiki.samba.org/index.php/Configure_Samba_to_Work_Better_with_Mac_OS_X
        "vfs objects" = "catia fruit streams_xattr"; # added catia
        "fruit:metadata" = "stream";
        "fruit:model" = "RackMac";
        "fruit:veto_appledouble" = "no";
        "fruit:nfs_aces" = "no";
        "fruit:wipe_intentionally_left_blank_rfork" = "yes";
        "fruit:delete_empty_adfiles" = "yes";
        "fruit:posix_rename" = "yes";
      };
      "timemachine" = {
        "fruit:time machine" = "yes";
        "fruit:time machine max size" = "2T";
        "path" = "/mnt/backup/timemachine";
        "comment" = "os x time machine backups";
        "writeable" = "yes";
      };
      "transmission" = {
        "path" = "/var/lib/transmission";
        "comment" = "transmission daemon directory";
        "writeable" = "yes";
      };
      "slskd" = {
        "path" = "/var/lib/slskd";
        "comment" = "soulseek daemon directory";
        "writeable" = "yes";
      };
      "general" = {
        "path" = "/srv/general";
        "comment" = "general miscellaneous stuff, like docs and downloads and other archival things";
        "writeable" = "yes";
      };
      "media" = {
        "path" = "/srv/media";
        "comment" = "devin's music, tv (mostly anime), movies, and more";
        "writeable" = "yes";
      };
    };
  };
}
