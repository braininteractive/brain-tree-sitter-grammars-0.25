{ config, lib, pkgs, ... }:

with lib;

{
  options.services.demo = {
    enable = mkEnableOption "demo service";
    port = mkOption {
      type = types.port;
      default = 8080;
      description = "Listen port.";
    };
  };

  config = mkIf config.services.demo.enable {
    systemd.services.demo = {
      wantedBy = [ "multi-user.target" ];
      serviceConfig.ExecStart = "${pkgs.demo}/bin/demo --port ${toString config.services.demo.port}";
    };
  };
}
