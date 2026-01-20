{...}: {
  services.immich = {
    enable = true;
    accelerationDevices = null;
    openFirewall = true;
  };
  users.users.immich.extraGroups = ["video" "render"];
}
