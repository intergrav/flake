{...}: {
  services = {
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
      settings.PermitRootLogin = "no";
    };
    fail2ban.enable = true;
  };
}
