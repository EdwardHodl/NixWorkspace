{ config, pkgs, stdenv, ... }:

{
  # Enable the MariaDB service
  # https://nixos.org/manual/nixos/stable/options.html#opt-services.mysql.enable

  # ensure dataDir is created by mysql
  systemd.tmpfiles.rules = [
    "d /home/edward/NixWorkspace/MySQL/data 0755 edward users - -"
  ];
 
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    user="edward";
    configFile = pkgs.writeText "my.cnf" ''
      [mysqld]
      datadir=/home/edward/NixWorkspace/MySQL/data
      port=3306
      user=edward
    '';

    ensureDatabases = [ "mempool" ];    
    initialScript = pkgs.writeText "initialScript" ''
        CREATE USER IF NOT EXISTS 'mempool'@'localhost';
        GRANT ALL PRIVILEGES ON mempool.* TO 'mempool'@'localhost';
        ALTER USER 'mempool'@'localhost' IDENTIFIED BY 'mempool';
        FLUSH PRIVILEGES;
    '';
  };
}
