{ config, pkgs, ... }:

  let
    pathToExec = pkgs.writeShellScript "privatenet.sh"
      ''
      #!/bin/sh
      NAME="privatenet.service"
      echo "$NAME: ### Starting ###"

      echo "Account and Key"
      ACCOUNT=$(mullvad account get)
      # if not logged in, then login
      # also, logout on service stop
      if echo "$ACCOUNT" | grep -q "Not logged in on any account"; then
        echo "$ACCOUNT"
        exit 1
      else
        echo "$ACCOUNT" | grep -A 1 "Device name"
      fi

      #mullvad tunnel wireguard key check

      echo "Configure Interface"
      mullvad auto-connect set on
      mullvad lan set allow
      mullvad dns set default --block-ads --block-malware --block-trackers --block-gambling --block-adult-content
      mullvad obfuscation set mode auto

      echo "Configure Relay and Tunnel"
      mullvad relay set tunnel-protocol wireguard
      mullvad relay set location us
      mullvad tunnel wireguard quantum-resistant-tunnel set off

      echo "Check Status and Always Connect"
      while :
      do
        STATUS=$(mullvad status)
        echo $STATUS
        if echo "$STATUS" | grep -q "Connected"; then
          sleep 5
        else
          echo "Mullvad is not connected, connecting..."
          mullvad connect
          sleep 2
        fi
      done

      # Update Commands.
      # mullvad tunnel wireguard key regenerate
      # mullvad relay update
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
      User="${config.lapbox.username}";
    };
  };
}
