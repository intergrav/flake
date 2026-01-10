{pkgs, ...}: let
	isDarwin = pkgs.stdenv.isDarwin;
	homeDir =
		if isDarwin
		then "/Users/devin"
		else "/home/devin";
in {
	users.users.devin =
		{
			home = homeDir;
			shell = pkgs.fish;
		}
		// (
			if isDarwin
			then {uid = 501;}
			else {
				isNormalUser = true;
				extraGroups = ["networkmanager" "wheel"];
			}
		);

	home-manager.users.devin = {pkgs, ...}: {
		imports = [
			./programs/fastfetch.nix
			./programs/fish.nix
			./programs/git.nix
			./programs/neovim.nix
			./programs/tmux.nix
		];
		home = {
			username = "devin";
			homeDirectory = homeDir;
			stateVersion = "23.11";
			packages = with pkgs; [
				alejandra
				bat
				bun
				coreutils
				just
				nh
				nix-your-shell
				nixd
				packwiz
				rsync
				starship
				tree
				xz
			];
		};
		programs.home-manager.enable = true;
	};
}
