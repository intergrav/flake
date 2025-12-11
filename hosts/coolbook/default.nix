{pkgs, ...}: {
  networking.hostName = "coolbook";

  homebrew = {
    taps = ["mhaeuser/mhaeuser"];
    casks = [
      "affinity"
      "bambu-studio"
      "battery-toolkit"
      "discord"
      "font-sf-compact"
      "font-sf-mono"
      "font-sf-pro"
      "ghostty"
      "iina"
      "inkscape"
      "keka"
      "meshlab"
      "mos"
      "musescore"
      "netnewswire"
      "obsidian"
      "omnidisksweeper"
      "onyx"
      "prismlauncher"
      "rnnoise"
      "rockboxutility"
      "signal"
      "steam"
      "tailscale-app"
      "utm"
      "valhalla-freq-echo"
      "valhalla-space-modulator"
      "valhalla-supermassive"
      "visual-studio-code"
    ];
  };

  environment.systemPackages = with pkgs; [
    xz
    rsync
    cinny-desktop
  ];
}
