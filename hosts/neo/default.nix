{pkgs, ...}: {
  networking.hostName = "neo";

  homebrew = {
    casks = [
      "affinity"
      "bambu-studio"
      "discord"
      "font-sf-compact"
      "font-sf-mono"
      "font-sf-pro"
      "ghostty"
      "helium-browser"
      "iina"
      "inkscape"
      "keka"
      "meshlab"
      "moonlight"
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
      "sf-symbols"
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
    qutebrowser
  ];
}
