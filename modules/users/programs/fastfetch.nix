{...}: {
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "small";
      };
      modules = [
        "title"
        "uptime"
        "host"
        "os"
        "localip"
        "disk"
        "media"
      ];
    };
  };
}
