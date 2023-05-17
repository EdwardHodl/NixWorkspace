{ config, pkgs, ... }:

{
   imports = [
    # Mempool
    ./MySQL/configuration.nix
    ./Nextcloud.nix
   ];
}
