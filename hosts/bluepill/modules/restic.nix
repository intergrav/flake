{...}: {
  age.secrets.restic = {
    file = ../../../secrets/restic.age;
    owner = "root";
    group = "root";
  };
  age.secrets.rclone-onedrive = {
    file = ../../../secrets/rclone-onedrive.age;
    owner = "root";
    group = "root";
  };

  services.restic = {
    server = {
      enable = true;
      dataDir = "/mnt/backup/restic";
      extraFlags = ["--no-auth"];
    };
    backups = {
      "bluepill" = {
        repository = "/mnt/backup/restic/devin";
        passwordFile = config.age.secrets.restic.path;
        initialize = true;
        timerConfig = {
          OnCalendar = "hourly";
          Persistent = true;
        };
        paths = [
          "/etc/secrets"
          "/etc/age.key"
          "/home"
          "/srv"
          "/var/lib"
        ];
        exclude = [
          "/var/lib/transmission"
        ];
        extraBackupArgs = ["--skip-if-unchanged" "--no-scan" "--one-file-system" "--exclude-caches" "--tag scheduled"];
        pruneOpts = ["--keep-last 4" "--keep-hourly 24" "--keep-daily 14" "--keep-weekly 4" "--keep-monthly 6"];
      };
      "bluepill-offsite" = {
        repository = "rclone:onedrive:/backup/restic/devin";
        passwordFile = config.age.secrets.restic.path;
        rcloneConfigFile = config.age.secrets.rclone-onedrive.path;
        initialize = true;
        timerConfig = {
          OnCalendar = "daily";
          Persistent = true;
        };
        paths = [
          "/etc/secrets"
          "/etc/age.key"
          "/home"
          "/srv"
          "/var/lib"
        ];
        exclude = [
          "/var/lib/transmission"
        ];
        extraBackupArgs = ["--skip-if-unchanged" "--no-scan" "--one-file-system" "--exclude-caches" "--tag scheduled"];
        pruneOpts = ["--keep-last 4" "--keep-hourly 24" "--keep-daily 14" "--keep-weekly 4" "--keep-monthly 6"];
      };
    };
  };
}
