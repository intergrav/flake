{
	config,
	pkgs,
	...
}: {
	services.jellyfin = {
		enable = true;
		openFirewall = true;
	};

	hardware.graphics.enable = true;
	services.xserver.videoDrivers = ["nvidia"];
	hardware.nvidia = {
		open = false;
		nvidiaSettings = true;
		package = config.boot.kernelPackages.nvidiaPackages.stable;
		modesetting.enable = false;
		powerManagement.enable = false;
		powerManagement.finegrained = false;
	};
}
