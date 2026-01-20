{...}: {
  services.immich = {
    enable = true;
    openFirewall = true;
  };

  users.users.immich.extraGroups = ["video" "render"];
}
