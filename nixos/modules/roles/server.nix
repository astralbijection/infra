{ homeModules, sshKeyDatabase }:
{ config, lib, ... }:
with lib; {
  options.astral.roles.server.enable = mkOption {
    description = "Bare metal server";
    default = false;
    type = types.bool;
  };

  config = mkIf config.astral.roles.server.enable {
    astral = {
      net.sshd.enable = true;
      infra-update.enable = false; # don't update automatically because everything's broken
    };

    # Enable SSH in initrd for debugging
    boot.initrd.network.ssh = {
      enable = true;
      authorizedKeys = [ sshKeyDatabase.users.astrid ];
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      users.astrid = homeModules.astral-cli;
    };

    # Passwordless sudo
    security.sudo.wheelNeedsPassword = false;
    users.mutableUsers = false;
  };
}
