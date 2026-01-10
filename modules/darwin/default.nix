{lib, ...}: {
	system.stateVersion = 6;
	system.primaryUser = "devin";
	nixpkgs.hostPlatform = lib.mkDefault "aarch64-darwin";

	homebrew = {
		enable = true;
		onActivation = {
			autoUpdate = true;
			cleanup = "zap";
			upgrade = true;
		};
	};
}
