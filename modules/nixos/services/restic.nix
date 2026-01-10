{...}: {
	age.secrets.restic = {
		file = ../../../secrets/restic.age;
		owner = "root";
		group = "root";
		path = "/etc/secrets/restic";
	};

	services.restic = {
		server = {
			enable = true;
			dataDir = "/mnt/backup/restic";
			extraFlags = ["--no-auth"];
		};
		backups = {
			"bluepill" = {
				repository = "/mnt/backup/restic/bluepill";
				passwordFile = "/etc/secrets/restic";
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
				pruneOpts = ["--keep-hourly 24" "--keep-daily 14" "--keep-weekly 4" "--keep-monthly 6" "--keep-yearly 2"];
			};
		};
	};
}
