{pkgs, ...}: {
	home.packages = with pkgs; [
		gh
		lazygit
	];

	programs.git = {
		enable = true;
		settings = {
			user.name = "intergrav";
			user.email = "devin@devins.page";
			credential.helper = "!gh auth git-credential";
			pull.rebase = true;
			rebase.autoStash = true;
		};
	};
}
