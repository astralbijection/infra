{ config, pkgs, lib, ... }:
with lib;
let cfg = config.astral.roles.armqr;
in {
  options.astral.roles.armqr.enable = mkEnableOption "armqr server";

  config = mkIf cfg.enable {
    services.armqr = {
      enable = true;
      port = 63423;
    };

    services.nginx = {
      enable = true;
      virtualHosts."qr.arm.astridyu.com" = {
        enableACME = true;
        forceSSL = false;
        locations."/".proxyPass =
          "http://127.0.0.1:${toString config.services.armqr.port}";
      };
    };
  };
}
