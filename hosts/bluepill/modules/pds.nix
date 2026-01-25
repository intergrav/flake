{config, ...}: {
  age.secrets.pds = {
    file = ../../../secrets/pds.age;
    owner = "pds";
    group = "pds";
  };

  services.bluesky-pds = {
    enable = true;
    environmentFiles = [config.age.secrets.pds.path];
    settings = {
      PDS_PORT = 3000;
      PDS_HOST = "0.0.0.0";
      PDS_HOSTNAME = "pds.devins.page";
      PDS_SERVICE_HANDLE_DOMAINS = ".pds.devins.page";
      PDS_ADMIN_EMAIL = "devin@devins.page";
    };
  };
}
