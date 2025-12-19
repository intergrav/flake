{...}: {
  imports = [
    ./hardware.nix
    ./services/caddy.nix
    ./services/nftables.nix
    ./services/ssh.nix
    ./services/tailscale.nix
  ];

  networking.hostName = "bluepill-proxy";
  networking.domain = "";
  networking.networkmanager.enable = true;

  documentation = {
    enable = false;
    man.enable = false;
    info.enable = false;
    doc.enable = false;
  };

  age.identityPaths = ["/etc/age.key"];
}
