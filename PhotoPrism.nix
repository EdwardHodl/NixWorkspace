{ config, pkgs, ... }:
let
  port = 2342;
in
{
  services.photoprism.enable = true;
  services.photoprism = {
    package = pkgs.photoprism;
    #storagePath = /home/edward/NixWorkspace/PhotoPrism/data;
    address = "0.0.0.0";
    port = port; # default 2342
    originalsPath = /var/lib/nextcloud/data;
    settings = {
      PHOTOPRISM_HTTP_PORT = port;
      PHOTOPRISM_HTTP_HOST = "0.0.0.0";
      PHOTOPRISM_ADMIN_USER = "root";
      PHOTOPRISM_ADMIN_PASSWORD = "test123";
      PHOTOPRISM_LOG_LEVEL = "debug";

      #PHOTOPRISM_CONFIG_PATH = "/home/edward/NixWorkspace/PhotoPrism/options.yml";
      #PHOTOPRISM_ORIGINALS_PATH = "/var/lib/nextcloud/data";

      PHOTOPRISM_DEFAULT_LOCALE = "en";
    };
  };
  networking.firewall = {
    allowedTCPPorts = [ port ];
    allowedUDPPorts = [ port ];
  };
}

