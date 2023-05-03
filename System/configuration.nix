# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./power.nix
      ./net.nix
      ./ssh.nix
      ../serviceconfig.nix
    ];
  nix.settings.experimental-features = ["nix-command" "flakes"];
}
