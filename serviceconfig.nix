{ config, pkgs, ... }:

{
   imports = [
    # Mempool
    ./MySQL/configuration.nix

    ./Nextcloud.nix
    #./PhotoPrism.nix
   ];


   services.photoprism = {
    enable = true;
    package = pkgs.photoprism;
    #storagePath = /home/edward/NixWorkspace/PhotoPrism/data;
    address = "0.0.0.0";
    port = 2342; # default 2342
    originalsPath = /var/lib/nextcloud/data;
    settings = {
      PHOTOPRISM_ADMIN_USER = "root";
      PHOTOPRISM_DEFAULT_LOCALE = "en";
    };
  };
}
