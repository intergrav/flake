{lib, ...}: {
	imports = [
		./services/fwupd.nix
		./services/ssh.nix
		./services/tailscale.nix
	];

	system.stateVersion = lib.mkDefault "24.11";
	nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

	boot.loader = {
		systemd-boot.enable = lib.mkDefault true;
		efi.canTouchEfiVariables = lib.mkDefault true;
	};

	zramSwap.enable = true;
	time.timeZone = lib.mkDefault "America/Nassau";
	i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
}
