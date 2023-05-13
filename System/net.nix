{ config, pkgs, ... }:

{
  # System packages
  environment.systemPackages = with pkgs; [
    protonvpn-cli
  ];

  # Enable Networking
  networking.hostName = "lapbox"; # Define your hostname.
  networking.networkmanager.enable = true;

  # 
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("networkmanager")
          && (action.id.indexOf("org.freedesktop.NetworkManager.") == 0 ||
              action.id.indexOf("org.freedesktop.login1") == 0)
        )
      {
        return polkit.Result.YES;
      }
    })
  '';

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  # Or disable the firewall altogether.
  networking.firewall.enable = true;
 
  services.avahi = {
    enable = true;
    nssmdns = true;
    wideArea = false;
    reflector = true;
    domainName = "local";
    publish = {
      enable = true;
      addresses = true;
      workstation = false;
      domain = true;
    };
    openFirewall = true; # UDP port 5353
  };
 
  # 3000 - RTL
  # 4001 - RTL docs
  # 4200 - mempool
  # 1122 - mosh alternative
  # 8080 - RTL
  # 50001 - Electrum Server
  # 8801 - (nostr) web socket
  networking.firewall.allowedTCPPorts = [ 22 1122 3000 4001 4200 8080 8801 50001 ];

  # 60000 - 60100 - mosh
  networking.firewall.allowedUDPPortRanges = [ {from = 60000; to = 60100;} ];
}
