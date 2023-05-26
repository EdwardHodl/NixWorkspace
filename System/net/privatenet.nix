{ config, pkgs, ... }:

  let
    pathToExec = pkgs.writeShellScript "privatenet.sh"
      ''
      #!/bin/sh
      NAME="privatenet.service"
      echo "$NAME: ### Starting ###" | systemd-cat -p info

      while :
      do
        STATUS=$(mullvad status)
        echo $STATUS | systemd-cat -p info
        if echo "$STATUS" | grep -q "Connected"; then
          echo "Mullvad is connected"
        else
          echo "Mullvad is not connected, connecting..."
          mullvad connect
        fi

        sleep 2
      done
      '';
  in
{
  # System packages
  environment.systemPackages = with pkgs; [
    mullvad
  ];

  services.mullvad-vpn.enable = true;

  systemd.services.privatenet = {
    enable = true;
    path = [ pkgs.mullvad ];

    unitConfig = {
      Description="Privacy network reconnect script";
      Wants="network.target";
      After="network.target";
    };

    serviceConfig = {
      Type="simple";
      ExecStart="${pathToExec}";
      Restart="always";
      User=config.users.users.edward.name;
    };
  };
}
