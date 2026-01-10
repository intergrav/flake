{...}: {
	age.secrets.navidrome = {
		file = ../../../secrets/navidrome.age;
		owner = "navidrome";
		group = "navidrome";
		path = "/etc/secrets/navidrome";
	};

	services.navidrome = {
		enable = true;
		openFirewall = true;
		environmentFile = "/etc/secrets/navidrome";
		settings = {
			MusicFolder = "/srv/media/music";
			Address = "0.0.0.0";
			CoverArtPriority = "cover.*, folder.*, front.*, embedded";
		};
	};
}
