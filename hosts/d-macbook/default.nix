{pkgs, ...}: {
  networking.hostName = "d-macbook";

  homebrew = {
    casks = [
      "affinity"
      "bambu-studio"
      "discord"
      "font-sf-compact"
      "font-sf-mono"
      "font-sf-pro"
      "ghostty"
      "glide"
      "helium-browser"
      "hytale"
      "iina"
      "inkscape"
      "keka"
      "meshlab"
      "moonlight"
      "motrix"
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
      "transmission"
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
