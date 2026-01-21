{...}: {
  services.immich = {
    enable = true;
    accelerationDevices = null;
    openFirewall = true;
    host = "0.0.0.0";
  };
  users.users.immich.extraGroups = ["video" "render"];
}
