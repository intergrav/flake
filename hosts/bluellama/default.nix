{pkgs, ...}: {
  networking.hostName = "bluellama";

  homebrew = {
    brews = [
      {
        name = "colima";
        restart_service = "changed";
      }
      "docker"
      "docker-compose"
      {
        name = "ollama";
        restart_service = "changed";
      }
      "tailscale"
    ];
  };
}
