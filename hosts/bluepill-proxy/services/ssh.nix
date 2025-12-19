{...}: {
  services = {
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
    };

    fail2ban.enable = true;
  };
}
