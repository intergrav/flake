{pkgs, ...}: {
  networking.hostName = "neo";

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
      "mpluginmanager"
      "musescore"
      "netnewswire"
      "obsidian"
      "omnidisksweeper"
      "onyx"
      "prismlauncher"
      "rnnoise"
      "roblox"
      "robloxstudio"
      "rockboxutility"
      "signal"
      "steam"
      "tailscale-app"
      "uninstallpkg"
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
    qutebrowser
  ];
}
