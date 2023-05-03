{ config, pkgs, ... }:

{
  # System packages
  environment.systemPackages = with pkgs; [
    pkgs.protonvpn-cli
  ];

  # Enable Networking
  networking.hostName = "lapbox"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  
  # 3000 - RTL
  # 4001 - RTL docs
  # 4200 - mempool
  # 1122 - mosh alternative
  # 8080 - RTL
  # 50001 - Electrum Server
  networking.firewall.allowedTCPPorts = [ 22 1122 3000 4001 4200 8080 50001 ];

  # 60000 - 60100 - mosh
  networking.firewall.allowedUDPPortRanges = [ {from = 60000; to = 60100;} ];

  # Proton-CLI. Login, connect, enable killswitch.
  boot.postBootCommands = ''
    protonvpn-cli killswitch --off
    protonvpn-cli login
    protonvpn-cli connect --tor
    protonvpn-cli killswitch --on
  '';
}

