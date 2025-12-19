{pkgs, ...}: {
  imports = [
    ./hardware.nix
    ./services/ssh.nix
    ./services/tailscale.nix
  ];

  networking.hostName = "bluepill-proxy";
  networking.domain = "";

  documentation = {
    enable = false;
    man.enable = false;
    info.enable = false;
    doc.enable = false;
  };

  age.identityPaths = ["/etc/age.key"];
}
