{ config, ... }:

{
  # see:  https://nixos.wiki/wiki/Logind
  services.logind.extraConfig = ''
    # Ignore LidSwitch power actions
    HandleLidSwitch=ignore
    HandleLidSwitchExternalPower=ignore
    HandleLidSwitchDocked=ignore

    # Disable Power key
    HandlePowerKey=ignore

    # Disable taken action when the system is idle
    IdleAction=ignore
    IdleActionSec=infinity
  '';
}
