{pkgs, ...}: {
  imports = [../users/devin.nix];

  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
    optimise.automatic = true;
    settings.experimental-features = ["flakes" "nix-command"];
  };

  nixpkgs.config.allowUnfree = true;

  programs.fish.enable = true;
  environment.shells = [ pkgs.fish ];
}
