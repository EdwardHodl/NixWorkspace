{config, pkgs, ... }:
{
  networking.firewall.allowedTCPPorts = [ 9090 9002 9003 9004 9005 9006 3030 ];

  services.grafana = {
    enable = true;
    settings.server = {
      protocol = "http";
      http_addr = "0.0.0.0";
      http_port = 3030;
      domain = "lapbox.local";
    };
  };

  services.prometheus = {
    enable = true;
    port = 9090;
    exporters = {
      systemd.enable = true;
      systemd = {
        port = 9006;
      };
#      postgres.enable = true;
      process.enable = true;
      process = {
        port = 9005;
      };
      node.enable = true;
      node = {
        enabledCollectors = [ "logind" "systemd" "processes" ];
        port = 9002;
        
      };
      #nginx.enable = true;
      nextcloud.enable = true;
      nextcloud = {
        port = 9004;
        url = "http://lapbox.local";
        username = "prometheus";
        user = "prometheus";
        passwordFile = /home/edward/NixWorkspace/System/Secrets/prometheus_exporter_password.txt;
      };
      bitcoin.enable = true;
      bitcoin = {
        port = 9003;
        rpcUser = "prometheus";
        rpcPasswordFile = /home/edward/NixWorkspace/System/Secrets/prometheus_exporter_password.txt;
      };
#      sql.enable = true;
    };

    globalConfig = {
      scrape_interval = "5s";
    };

    scrapeConfigs = [
      {
        job_name = "node";
        static_configs = [{
          targets = [ "localhost:${toString config.services.prometheus.exporters.node.port}" ];
        }];
      }
      {
        job_name = "bitcoin";
        static_configs = [{
          targets = [ "localhost:${toString config.services.prometheus.exporters.bitcoin.port}" ];
        }];
      }
      {
        job_name = "corelightning";
        static_configs = [{
          targets = [ "localhost:9750" ];
        }];
      }
      {
        job_name = "nextcloud";
        static_configs = [{
          targets = [ "localhost:${toString config.services.prometheus.exporters.nextcloud.port}" ];
        }];
      }
      {
        job_name = "process";
        static_configs = [{
          targets = [ "localhost:${toString config.services.prometheus.exporters.process.port}" ];
        }];
      }
      {
        job_name = "systemd";
        static_configs = [{
          targets = [ "localhost:${toString config.services.prometheus.exporters.systemd.port}" ];
        }];
      }
    ];
  };
}
