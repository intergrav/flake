{pkgs, ...}: {
	home.packages = with pkgs; [
		fzf
		fd
		bat
		grc
	];

	programs.fish = {
		enable = true;
		interactiveShellInit = ''
			if command -q nix-your-shell
			  nix-your-shell fish | source
			end
			starship init fish | source
			fish_add_path /opt/homebrew/bin
			fastfetch
			set fish_greeting
		'';
		plugins = [
			{
				name = "fzf-fish";
				src = pkgs.fishPlugins.fzf-fish.src;
			}
			{
				name = "grc";
				src = pkgs.fishPlugins.grc.src;
			}
		];
	};
}
