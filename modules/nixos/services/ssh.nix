{...}: {
  services = {
    openssh = {
      enable = true;
      settings.PasswordAuthentication = true;
    };
    fail2ban.enable = true;
  };
}
