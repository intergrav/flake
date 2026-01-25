{...}: {
  services = {
    tangled = {
      knot = {
        enable = true;
        stateDir = "/srv/knot";
        server = {
          hostname = "knot.devins.page";
          owner = "did:plc:3xpaniu6rs7fygzthgmtuv7c";
        };
      };
      spindle = {
        enable = true;
        server = {
          hostname = "spindle.devins.page";
          owner = "did:plc:3xpaniu6rs7fygzthgmtuv7c";
        };
      };
    };
  };
}
