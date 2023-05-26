# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # enabled with adding the nixos-hardware channel.
      <nixos-hardware/lenovo/thinkpad/e495/default.nix>

      ./power.nix
      ./net.nix
      ./ssh.nix
      ../serviceconfig.nix
    ];
  
  environment.systemPackages = with pkgs; [ vim less git ];
  nix.settings.experimental-features = ["nix-command" "flakes"];
}
