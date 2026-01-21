{...}: {
  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
    allowedHosts = "*";
    widgets = [
      {
        resources = {
          label = "Statistics";
          cpu = true;
          memory = true;
          cputemp = true;
          uptime = true;
          units = "imperial";
          network = true;
        };
      }
      {
        resources = {
          label = "Internal";
          disk = "/";
        };
      }
      {
        resources = {
          label = "Backups";
          disk = "/mnt/backup";
        };
      }
      {
        search = {
          provider = "duckduckgo";
          target = "_blank";
        };
      }
    ];
  };
}
