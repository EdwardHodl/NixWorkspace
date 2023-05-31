{config, pkgs, ...}:
{

  # ## Setup Nextcloud, with NGIX and PostgreSQL.
  #   Using default values for data and config paths.
  #   Creates postgre and nextcloud system users.
  #
  # TODO: Self-signed certs and force HTTPS for .local domain
  # TODO: Exercise database and data backup and recovery.
  #
  # following: https://jacobneplokh.com/how-to-setup-nextcloud-on-nixos/
  # further references:
  #   wiki: https://nixos.wiki/wiki/Nextcloud
  #   nixos man: https://nixos.org/manual/nixos/stable/index.html#module-services-nextcloud
  #   nixos opts: https://search.nixos.org/options?channel=22.11&from=0&size=50&sort=relevance&type=packages&query=services.nextcloud

  # Let's Encrypt, accept terms to generate a certifcate
  #security.acme = {
  #  acceptTerms = false; #true;
  #  defaults.email = "edwardhodl@protonmail.com";
  #};

  # PostgreSQL, recommended over SQLite.
  services.postgresql = {
    enable = true;

    # Ensure the database, user, and permissions always exist
    ensureDatabases = [ "nextcloud" ];
    ensureUsers = [
      {
        name = "nextcloud";
        ensurePermissions."DATABASE nextcloud" = "ALL PRIVILEGES";
      }
    ];

  };

  # override the default user:group (postgres:postgres) to edward:users
  ## so the datadir can locate in a home dir
  ## see: https://nixos.wiki/wiki/Nix_Cookbook#Error:_the_option_has_conflicting_definitions
  #  systemd.services.postgresql.serviceConfig = pkgs.lib.mkOverride 0 { User="edward"; Group="users";};

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  # NGINX is used as a 'reverse-proxy' to route requests for the virtualhost to a localhost port
  services.nginx = {
    enable = true;

    # use recommended settings
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    # only allow PFS-enabled ciphers with AES256
    sslCiphers = "AES256+EECDH:AES256+EDH:!aNULL";

    # Setup Nextcloud virtual host to listen on ports
    virtualHosts = {
      "lapbox.local" = {
        listenAddresses = [ "0.0.0.0" ];
        ## Force HTTP redirect to HTTPS
        # forceSSL = true;
        ## LetsEncrypt
        # enableACME = true;
      };
    };  
  };

  environment.systemPackages = [ pkgs.nextcloud26 ];

  # The Nextcloud service
  services.nextcloud = {
    enable = true;
    hostName = "lapbox.local";
    package = pkgs.nextcloud26;

    # change paths to home dir
    # home = "/home/edward/NixWorkspace/Nextcloud/data";

    # Enable built-in virtual host management
    # nginx.enable = true; on by default.

    # Use HTTPS for links
    # https = true;

    # Auto-update Nextcloud Apps
    autoUpdateApps.enable = true;
    autoUpdateApps.startAt = "00:00:00";

    extraApps = with pkgs.nextcloud26Packages.apps; {
      inherit contacts unsplash files_texteditor deck calendar; # bookmarks mail files_markdown
    };
    extraAppsEnable = true;

    config = {
      # Further forces nextcloud to use HTTPS
      # overwriteProtocol = "https";

      # Nextcloud PostegreSQL database configuration
      dbtype = "pgsql";
      dbuser = "nextcloud";
      dbhost = "/run/postgresql";
      dbname = "nextcloud";
      dbpassFile = "${pkgs.writeText "dbpass" "test123"}";

      adminuser = "admin";
      adminpassFile = "${pkgs.writeText "adminpass" "test123"}";
    };
  };

  # Ensure PostgreSQL is running before Nextcloud
  systemd.services."nextcloud-setup" = {
    requires = ["postgresql.service"];
    after = ["postgresql.service"];

#    ## Override the service's runas User:Group
#    serviceConfig = pkgs.lib.mkOverride 0 { User="edward"; Group="users";};
  };
}

