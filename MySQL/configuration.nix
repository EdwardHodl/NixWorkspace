{ config, pkgs, stdenv, ... }:

{
  # Enable the MariaDB service
  # https://nixos.org/manual/nixos/stable/options.html#opt-services.mysql.enable

  # ensure dataDir is created by mysql
  systemd.tmpfiles.rules = [
    "d ${config.lapbox.homedir}/${config.lapbox.workspacename}/MySQL/data 0755 ${config.lapbox.username} ${config.lapbox.groupname} - -"
  ];
 
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    user="${config.lapbox.username}";
    configFile = pkgs.writeText "my.cnf" ''
      [mysqld]
      datadir=${config.lapbox.homedir}/${config.lapbox.workspacename}/MySQL/data
      port=3306
      user=${config.lapbox.username}
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
